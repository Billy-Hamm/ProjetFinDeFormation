unit FrEmployeMaquetteFdp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, logiquePartager, FMX.Ani,
  FMX.Layouts, FMX.ScrollBox, FMX.Memo;

type
  tabHeures = array of string;
  tabConfig = array of string;
  tabElementPointage = array of string;
  tabCheck = array [0..3] of TCheckBox;
  TemployeMaquetteFdp = class(TFrame)
    employeFdp: TRectangle;
    photoEmploye: TImage;
    nomEmploye: TLabel;
    statutFdp: TRectangle;
    libelleStatut: TLabel;
    retard: TCheckBox;
    jrComplete: TCheckBox;
    heureArrive: TRectangle;
    Label5: TLabel;
    AH: TEdit;
    AM: TEdit;
    heureDepart: TRectangle;
    Label6: TLabel;
    DH: TEdit;
    DM: TEdit;
    Rectangle4: TRectangle;
    observation: TRectangle;
    Line4: TLine;
    Line3: TLine;
    heureSupplementaire: TRectangle;
    obs: TRectangle;
    _150: TCheckBox;
    _200: TCheckBox;
    aRecup: TCheckBox;
    recup: TCheckBox;
    heuresSup: TEdit;
    containerStatutFdp: TLayout;
    bgc: TRectangle;
    nonPresence: TRectangle;
    lNonPresence: TLabel;
    presence: TRectangle;
    lPresence: TLabel;
    absence: TRectangle;
    lAbsence: TLabel;
    appaStatutFdp: TFloatAnimation;
    dispStatutFdp: TFloatAnimation;
    erreurRenvoyer: TLabel;
    enableHeureArrive: TRectangle;
    enableHeureDepart: TRectangle;
    parentHeureSup: TRectangle;
    appaHeureSup: TFloatAnimation;
    dispHeureSup: TFloatAnimation;
    rotObsP: TFloatAnimation;
    rotObsPinverse: TFloatAnimation;
    Memo1: TMemo;
    appaMemoObs: TFloatAnimation;
    dispMemoObs: TFloatAnimation;
    obss: TRectangle;
    messageErreur: TRectangle;
    appaMessageErreur: TFloatAnimation;
    dispMessageErreur: TFloatAnimation;
    procedure statutFdpClick(Sender: TObject);
    procedure enableCheckABeforSelection (item : TCheckBox);
    procedure rendreEditAble ();
    function  controleurHeures(tab : tabHeures; editeur : TEdit; valeur : string):String;
    procedure configHeureMinute (tailleTab : integer;
    heureConfig : tabConfig; msgError : string);
    function convertirCheckbox (caseAcoche : TCheckBox) : string;
    function validationPointage(): tabElementPointage;
    function validationHeureSup() : tabElementPointage;
    procedure appaDispMessageErreur ();
    procedure reinitialisationPointage();
    procedure reinitialisationHeureSup();
    procedure fonctionHeures();
    procedure fonctionMinutes();
    procedure fonctionHeuresSup();
    procedure couleurErreur(edition : TEdit; codeErreur : Boolean);
    procedure Rectangle4Click(Sender: TObject);
    procedure _150Change(Sender: TObject);
    procedure _200Change(Sender: TObject);
    procedure aRecupChange(Sender: TObject);
    procedure employeFdpClick(Sender: TObject);
    procedure retardChange(Sender: TObject);
    procedure jrCompleteChange(Sender: TObject);
    procedure recupChange(Sender: TObject);
    procedure presenceClick(Sender: TObject);
    procedure nonPresenceClick(Sender: TObject);
    procedure absenceClick(Sender: TObject);
    procedure appaStatutFdpFinish(Sender: TObject);
    procedure dispStatutFdpFinish(Sender: TObject);
    procedure AHValidate(Sender: TObject; var Text: string);
    procedure AMValidate(Sender: TObject; var Text: string);
    procedure heuresSupValidate(Sender: TObject; var Text: string);
    procedure DHValidate(Sender: TObject; var Text: string);
    procedure DMValidate(Sender: TObject; var Text: string);
    procedure appaHeureSupFinish(Sender: TObject);
    procedure dispHeureSupFinish(Sender: TObject);
    procedure rotObsPFinish(Sender: TObject);
    procedure rotObsPinverseFinish(Sender: TObject);
    procedure appaMemoObsFinish(Sender: TObject);
    procedure dispMemoObsFinish(Sender: TObject);
    procedure obssClick(Sender: TObject);
    procedure appaMessageErreurFinish(Sender: TObject);
    procedure dispMessageErreurFinish(Sender: TObject);
  private
    { D?clarations priv?es }
  public
    { D?clarations publiques }
     selection : Boolean;
     // Cette variable permettra d'emp?cher de changer le statut de
     // pointage de l'employ? lors de l'ajout des heures suppl?mentaires
     HeureSupStop : Boolean;
     tabCheckbox : tabCheck;
  end;

  procedure reinitialiserCheck (caseAcocher : TCheckBox);

  { Cette fonction permet d'incr?menter la verificateurModification
   pour que cette derni?re remplisse sa fonction }
  procedure incrementverificateurModification ();
  procedure systemeRadioHeuresSup (tableauCheck : tabCheck; nameCase : string);
  procedure multipleSelection (nombreSelection : integer);
  procedure setToTrueEnableSelection ();
  function getCompteurSelection () : integer;


  var
     { Permet de g?rer le contenu de la variable selection au fur et
      ? mesure qu'on cliqueSur l'?l?ment employeFdp }
     toogleSelection : Boolean;
     { Permet de faire d'inverser l'animation qui est pr?vu pour le clique sur
     l'?l?ment d'observation (bouton) }
     toogleAnimObs : Boolean;
     { Va contenir le contenu l'heure minimum et maximum qui constuera l'intervalle
     de temps ? v?rifier et le message d'erreur qui peut ?tre g?n?r? si on est au-del?
     de cet intervalle }
     tableauHeures : tabHeures;
     { Permet de faire le compte des ?l?ments qui sont s?lectionn? }
     compteurSelection : integer;
     // Permettra de savoir s'il y a eu une erreur lors de la saisi des heures
     codeError : Boolean;
     { Cette variable permet d'interdire la selection si une de valeur d'un
     employ? a ?t? modifi? et pas valid?. Ce n'est que lors de la valida-
     tion que qu'on pourra faire des s?lections.
     Cette variable est r?initialis? par le bouton de validation sur la FDP }
     verificateurModification : integer;
     { Cette varaible permet de faire ? ce que lorsqu'on va consulter la fiche
     de pointage d'une date pass?, qu'on ait plus la possibilit? de modifier
     le contenu de cette fiche, parce que cette dernier va passer ? true et em-
     p?cher tout traitement sur l'employ? }
     enableSelection : Boolean;


implementation

{$R *.fmx}

function getCompteurSelection () : integer;
begin
     Result := compteurSelection;
end;

function TemployeMaquetteFdp.validationPointage(): tabElementPointage;
var tabPointage : tabElementPointage;
begin
   if libelleStatut.Text <> '' then
     begin
       if( ( (libelleStatut.Text = 'AB') and
            ( (retard.IsChecked = True) or (jrComplete.IsChecked = True) )
           ) or
           ( (libelleStatut.Text = 'NP') and (retard.IsChecked = True) )
         )
          then
            begin
              SetLength(tabPointage, 1);
              tabPointage[0] :='Incoh?rence au niveau du statut Employ?';
              Result := tabPointage;
            end
            else
              begin
                if StrToInt(AH.Text) >= StrToInt(DH.Text) then
                  begin
                     SetLength(tabPointage, 1);
                     tabPointage[0] := 'Probl?me avec les heures';
                     Result := tabPointage;
                  end
                  else
                    begin
                    // La taille totale du tableau doit ?tre 6 parce qu'il faut
                    // prendre en compte l'observation que l'en aura fait.
                      SetLength(tabPointage, 6);
                      tabPointage[0] := libelleStatut.Text;
                      tabPointage[1] := convertirCheckbox(retard);
                      tabPointage[2] := AH.Text + ':' + AH.Text;
                      tabPointage[3] := DH.Text +':' + DM.Text;
                      tabPointage[4] := convertirCheckbox(jrComplete);
                      tabPointage[5] := Memo1.Text;
                      Result := tabPointage;
                    end;
              end;

     end
     else
       begin
         SetLength(tabPointage, 1);
            tabPointage[0] := 'Remplissez la case statut';
            Result := tabPointage;
       end;
end;


function TemployeMaquetteFdp.validationHeureSup(): tabElementPointage;
var
   tabPointageSup : tabElementPointage;
   i : integer;
begin
   // La taille totale du tableau doit ?tre 3 parce qu'il faut
   // prendre en compte l'observation que l'en aura fait.
   SetLength(tabPointageSup, 2);
   tabPointageSup[0] := heuresSup.Text;
   for i := 0 to Length(tabCheckbox) - 1 do
     begin
       if tabCheckbox[i].IsChecked = True then
         begin
           tabPointageSup[1] := convertirCheckbox(tabCheckbox[i]);
           break;
         end;
     end;
     Result := tabPointageSup;
end;

procedure TemployeMaquetteFdp.reinitialisationPointage();
begin
   // on va aussi enlever l'animation de selection.
   verificateurModification := 0;
   selection := False;
end;

procedure TemployeMaquetteFdp.reinitialisationHeureSup();
begin
  HeureSupStop := False;
  // Animation de disparition
  dispHeureSup.Enabled := True;
  heureSupplementaire.Visible := False;
end;


function TemployeMaquetteFdp.convertirCheckbox (caseAcoche : TCheckBox) : string;
begin
  if caseAcoche.IsChecked = True then
     Result := '1'
     else
     Result := '0';
end;


procedure setToTrueEnableSelection ();
begin
  enableSelection := True;
end;


procedure TemployeMaquetteFdp.employeFdpClick(Sender: TObject);
begin

 if ((verificateurModification <= 0) and (enableSelection = False))  then
    begin
      if toogleSelection = False then
        begin
          selection := True;
          toogleSelection := True;
          rendreEditAble();
          // On va ajouter l'animation de selection
          compteurSelection := compteurSelection + 1;
        end
        else
            begin
              selection := False;
              toogleSelection := False;
              rendreEditAble();
              // On va ajouter l'animation de deselection
              compteurSelection := compteurSelection - 1;
            end;

        multipleSelection(compteurSelection);
        erreurRenvoyer.Text := 'J"ai ?t? selectionner';

    end;


end;



procedure multipleSelection (nombreSelection : integer);
begin
  // On va devoir cr?er un try catch parce qu'on va expressement provoquer
  //  une exception vu qu'on devoir d?truire queleque chose qui n'existe pas.

  if nombreSelection > 1 then
     // Cr?ation du mode multiS?lection.
     else
         // Destruction du mode multiSelection.
end;


procedure TemployeMaquetteFdp.rendreEditAble();
begin
  if selection = True then
     begin
       heureArrive.Enabled := True;
       heureDepart.Enabled := True;
       enableHeureArrive.Visible := False;
       enableHeureDepart.Visible := False;
     end
     else
         begin
           heureArrive.Enabled := False;
           heureDepart.Enabled := False;
           enableHeureArrive.Visible := True;
           enableHeureDepart.Visible := True;
         end;
end;


procedure incrementverificateurModification ();
begin
  verificateurModification  := verificateurModification + 1;
end;


procedure TemployeMaquetteFdp.statutFdpClick(Sender: TObject);
begin
   if ((selection = true) and (HeureSupStop = False)) then
     begin
       incrementverificateurModification ();
       containerStatutFdp.Visible := True;
       appaStatutFdp.Enabled := True;
     end;
end;




procedure TemployeMaquetteFdp.retardChange(Sender: TObject);
begin
     if selection = True then
       begin
          incrementverificateurModification ();
       end;
       enableCheckABeforSelection(retard);
end;



procedure TemployeMaquetteFdp.jrCompleteChange(Sender: TObject);
begin
     if selection = True then
       begin
          incrementverificateurModification ();
       end;
       enableCheckABeforSelection(jrComplete);
end;


procedure TemployeMaquetteFdp.absenceClick(Sender: TObject);
begin
libelleStatut.Text := lAbsence.Text;
dispStatutFdp.Enabled := True;
end;


procedure TemployeMaquetteFdp.nonPresenceClick(Sender: TObject);
begin
libelleStatut.Text := lNonPresence.Text;
dispStatutFdp.Enabled := True;
end;


procedure TemployeMaquetteFdp.obssClick(Sender: TObject);
begin
if toogleAnimObs = False then
      begin
        toogleAnimObs := True;
        rotObsP.Enabled := True;
      end
      else
        begin
          toogleAnimObs := False;
          rotObsPinverse.Enabled := True;
        end;
end;

procedure TemployeMaquetteFdp.appaMemoObsFinish(Sender: TObject);
begin
appaMemoObs.Enabled := False;
end;



procedure TemployeMaquetteFdp.dispMemoObsFinish(Sender: TObject);
begin
dispMemoObs.Enabled := False;
Memo1.Visible := False;
end;



procedure TemployeMaquetteFdp.rotObsPFinish(Sender: TObject);
begin
rotObsP.Enabled := False;
Memo1.Visible := True;
appaMemoObs.Enabled := True;
end;

procedure TemployeMaquetteFdp.rotObsPinverseFinish(Sender: TObject);
begin
rotObsPinverse.Enabled := False;
dispMemoObs.Enabled := True;
end;


procedure TemployeMaquetteFdp.presenceClick(Sender: TObject);
begin
libelleStatut.Text := lPresence.Text;
dispStatutFdp.Enabled := True;
end;






procedure TemployeMaquetteFdp.enableCheckABeforSelection (item : TCheckBox);
begin
  if selection = False then
  reinitialiserCheck(item);

end;



procedure reinitialiserCheck (caseAcocher : TCheckBox);
begin
  caseAcocher.IsChecked := False;
end;

// Heures suppl?mentaires

procedure TemployeMaquetteFdp.Rectangle4Click(Sender: TObject);
begin

     // Il va falloir d'abord v?rifier que le statut ? ?t? mis avant que ce
     // bouton puisse fonctionner, c'est pour la coh?rence des donn?es.
     if libelleStatut.Text <> '' then
        begin
          incrementverificateurModification ();
          HeureSupStop := True;
          tabCheckbox [0] := _150;
          tabCheckbox [1] := _200;
          tabCheckbox [2] := aRecup;
          tabCheckbox [3] := recup;
          // Il y aura du code en dessous notamment pour les heures sup.
          heureSupplementaire.Visible := True;
          appaHeureSup.Enabled := True;
        end;

end;


procedure TemployeMaquetteFdp._150Change(Sender: TObject);
begin
     systemeRadioHeuresSup(tabCheckbox, _150.Name);
end;


procedure TemployeMaquetteFdp._200Change(Sender: TObject);
begin
    systemeRadioHeuresSup(tabCheckbox, _200.Name);
end;


procedure TemployeMaquetteFdp.recupChange(Sender: TObject);
begin
systemeRadioHeuresSup(tabCheckbox, recup.Name);
end;


procedure TemployeMaquetteFdp.fonctionHeures();
var tabHeure : tabConfig;
    messageErreur : string;
begin
     // Le deux qui se voit partout repr?sente la taille du tableau des place
     // d'heure : heureDebut et heureFin ; minuteDebut et minuteFin
  SetLength(tabHeure, 2);
   messageErreur := 'Heure de travail : 8h - 17h';
   configHeureMinute(2, ['8','17'],messageErreur);
end;

procedure TemployeMaquetteFdp.fonctionMinutes;
var tabHeure : tabConfig;
    messageErreur : string;
begin
     SetLength(tabHeure, 2);
       messageErreur := 'Les minutes sont entre : 0 m - 59 m';
       configHeureMinute(2, ['0','59'], messageErreur);
end;


procedure TemployeMaquetteFdp.fonctionHeuresSup();
var tabHeure : tabConfig;
    messageErreur : string;
begin
     SetLength(tabHeure, 1);
       messageErreur := 'Pas plus de 5h de temps suppl?mentaire';
       configHeureMinute(1, ['5'], messageErreur);
end;


procedure TemployeMaquetteFdp.configHeureMinute (tailleTab : integer;
heureConfig : tabConfig; msgError : string);
begin
     // On ajoute ? tailleTab (+1) pour ajouter le message d'erreur dans le
     // tableau tabeleauHeure
 SetLength(tableauHeures, tailleTab+1);
     if tailleTab = 2 then
     begin
        tableauHeures[0] := heureConfig[0]; // Heure de d?but de travail
        tableauHeures[1] := heureConfig[1]; //heure de fin de travail
        tableauHeures[2] := msgError;
     end
     else if tailleTab = 1 then
       begin
            tableauHeures[0] := heureConfig[0]; // Heure de d?but de travail
            tableauHeures[1] := msgError;
       end;

end;


function TemployeMaquetteFdp.controleurHeures(tab : tabHeures;
         editeur : TEdit; valeur : string):String;
var f : integer;
begin
codeError := False;
  try
    f := StrToInt(valeur);
     if Length(tab) = 3 then
      begin
          if ((f < StrToInt(tab[0])) or (f > StrToInt(tab[1]))) then
           begin
             codeError := True;
             couleurErreur(editeur, codeError);
             Result := tab[2]
           end
           else
             begin
              codeError := False;
              couleurErreur(editeur, codeError);
             end;
      end
      else if Length(tab) = 2 then
           begin
             if ((f < 1) or (f > StrToInt(tab[0]))) then
               begin
                 codeError := True;
                 couleurErreur(editeur, codeError);
                 Result := tab[1]
               end
               else
                 begin
                   codeError := False;
                   couleurErreur(editeur, codeError);
                 end;
           end;

  except
  on e : exception do
    begin
      codeError := True;
      couleurErreur(editeur, codeError);
      Result := 'Mettez un entier';
    end;
  end;
end;


procedure TemployeMaquetteFdp.couleurErreur(edition : TEdit; codeErreur : Boolean);
var parentEdit : TRectangle;
begin
     parentEdit := edition.GetParentComponent as TRectangle;
     if codeErreur = True then
       begin
          parentEdit.Stroke.Thickness := 2;
          parentEdit.Stroke.Color := $FFFF0000;
       end
       else
           begin
              parentEdit.Stroke.Thickness := 0.5;
              parentEdit.Stroke.Color := TAlphaColors.Black ;
           end;
end;


procedure TemployeMaquetteFdp.appaDispMessageErreur ();
begin
  if codeError = True then
    begin
     messageErreur.Visible := True;
     appaMessageErreur.Enabled := True;
    end;
end;


procedure TemployeMaquetteFdp.appaMessageErreurFinish(Sender: TObject);
begin
    appaMessageErreur.Enabled := False;
    dispMessageErreur.Enabled := True;
end;

procedure TemployeMaquetteFdp.dispMessageErreurFinish(Sender: TObject);
begin
 dispMessageErreur.Enabled := False;
 messageErreur.Visible := False;
end;


procedure TemployeMaquetteFdp.DHValidate(Sender: TObject; var Text: string);
begin
  incrementverificateurModification ();
  fonctionHeures();
  erreurRenvoyer.Text := controleurHeures(tableauHeures, DH, Text);
  appaDispMessageErreur ();
end;


procedure TemployeMaquetteFdp.DMValidate(Sender: TObject; var Text: string);
begin
  incrementverificateurModification ();
  fonctionMinutes();
  erreurRenvoyer.Text := controleurHeures(tableauHeures, DM, Text);
  appaDispMessageErreur ();
end;


procedure TemployeMaquetteFdp.heuresSupValidate(Sender: TObject;
  var Text: string);
begin
  incrementverificateurModification ();
  fonctionHeuresSup();
  erreurRenvoyer.Text := controleurHeures(tableauHeures, heuresSup, Text);
  appaDispMessageErreur ();
end;


procedure TemployeMaquetteFdp.AHValidate(Sender: TObject; var Text: string);
begin
  incrementverificateurModification ();
  fonctionHeures();
  erreurRenvoyer.Text := controleurHeures(tableauHeures, AH, Text);
  appaDispMessageErreur ();
end;

procedure TemployeMaquetteFdp.AMValidate(Sender: TObject; var Text: string);
begin
  incrementverificateurModification ();
  fonctionMinutes();
  erreurRenvoyer.Text := controleurHeures(tableauHeures, AM, Text);
  appaDispMessageErreur ();
end;

procedure TemployeMaquetteFdp.appaHeureSupFinish(Sender: TObject);
begin
appaHeureSup.Enabled := False;
end;



procedure TemployeMaquetteFdp.appaStatutFdpFinish(Sender: TObject);
begin
appaStatutFdp.Enabled := False;
end;

procedure TemployeMaquetteFdp.aRecupChange(Sender: TObject);
begin
     systemeRadioHeuresSup(tabCheckbox, aRecup.Name);
end;


procedure TemployeMaquetteFdp.dispHeureSupFinish(Sender: TObject);
begin
dispHeureSup.Enabled := False;
heureSupplementaire.Visible := False;
end;



procedure TemployeMaquetteFdp.dispStatutFdpFinish(Sender: TObject);
begin
dispStatutFdp.Enabled := False;
containerStatutFdp.Visible := False;
end;


procedure systemeRadioHeuresSup (tableauCheck : tabCheck ; nameCase : string);
var i : integer;
begin

   for i := 0 to Length(tableauCheck)-1  do
   begin
      if tableauCheck[i].Name <> nameCase then
         begin
           if tableauCheck[i].IsChecked = True then
              begin
                tableauCheck[i].IsChecked := False;
              end;

         end;
   end;

end;



end.
