unit logiquePartager;

interface

uses System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
FMX.Graphics, FMX.Objects, FMX.Ani,  FMX.Dialogs, FrFiltreElementInformation,
FMX.StdCtrls;

type
  TtabFiltreSelect = array of string;
  TtabFiltreType = array of TfiltreElementInformation;

  TMaclasse = class(TObject)

  private
    procedure FinishTopElementEmployeAnim (Sender: TObject);
    procedure FinishTopElementEvalAnim (Sender: TObject);

    procedure FinishTousEmploye (Sender: TObject);
    procedure FinishTousEmployeEval (Sender: TObject);

    procedure FinishTopElementCongeAnim (Sender: TObject);
    procedure FinishTousEmployeConge (Sender: TObject);

    procedure FinishTopElementFdpAnim (Sender: TObject);
    procedure FinishTousElementFdpAnim (Sender: TObject);
  end;

// Les procédures

procedure appaTopElementEmploye ();
procedure appaTousEmployes ();

procedure appaTopElementEval ();
procedure appaTousEmployesEval ();

procedure appaTopElementConge ();
procedure appaTousEmployesConge ();

procedure appaTopElementFdp();
procedure appaTousEmployeFdp();

function elementSect (tabFiltre :  TtabFiltreType) : TtabFiltreSelect;
procedure requeteSql (sqlReq : string);
procedure requeteSqll (sqlReq : string);
procedure ExeRequeteSqlServer (reqSqlServer : string);

// Fiche de Pointage



// Les variable
var
  TopElementEmployeAnim : TFloatAnimation;
  TousEmployesAnim : TFloatAnimation;

  TopElementEvalAnim : TFloatAnimation;
  TousEmployeEvalAnim : TFloatAnimation;

  TopElementCongeAnim : TFloatAnimation;
  TousEmployeCongeAnim : TFloatAnimation;

  TopElementFdpAnim : TFloatAnimation;
  TousEmployeFdpAnim : TFloatAnimation;
  // Classe permet d'utiliser l'evenement OnFinish des animation
  classeEvent : TMaclasse;



implementation
uses dmBasesDeDonnees;

// Animation de tous les éléments
procedure animTout (anim : TFloatAnimation; proc : TNotifyEvent);
begin
  with anim do
      begin
        Duration := 0.5;
        OnFinish := proc;
        PropertyName := 'Opacity';
        StartValue := 0.000000000000000000;
        StopValue := 1.000000000000000000;
      end;
end;

procedure requeteSql (sqlReq : string);
begin
   with basesDeDonnees.FDQuery1 do
    begin
      try
       Close;
       SQL.Clear;
       SQL.Add(sqlReq);
       Open;
      Except
       on e : Exception do
        begin
        {
          Ajouter un peu de code pour une meilleur gestion de l'erreur
        }
          ShowMessage('Requęte échouée');
        end;

      end;
    end;


end;

procedure requeteSqll (sqlReq : string);
begin
   with basesDeDonnees.FDQuery2 do
    begin
      try
       Close;
       SQL.Clear;
       SQL.Add(sqlReq);
       Open;
      Except
       on e : Exception do
        begin
        {
          Ajouter un peu de code pour une meilleur gestion de l'erreur
        }
          ShowMessage('Requęte échouée');
        end;

      end;
    end;


end;



procedure ExeRequeteSqlServer (reqSqlServer : string);
begin
  with basesDeDonnees.ADOQuery1 do
    begin
      try
       Close;
       SQL.Clear;
       SQL.Add(reqSqlServer);
       Open;
      Except
       on e : Exception do
        begin
        {
          Ajouter un peu de code pour une meilleur gestion de l'erreur
        }
          ShowMessage('Requęte échouée');
        end;

      end;
    end;
end;


// Pour le top element Employé
procedure appaTopElementEmploye ();
begin
  classeEvent := TMaclasse.Create;
   TopElementEmployeAnim := TFloatAnimation.Create(nil);
   animTout(TopElementEmployeAnim, classeEvent.FinishTopElementEmployeAnim);
end;

procedure TMaclasse.FinishTopElementEmployeAnim (Sender: TObject);
begin
  TopElementEmployeAnim.Enabled := False;
  TopElementEmployeAnim.Free;
end;

// Pour les employés

procedure appaTousEmployes ();
begin
    classeEvent := TMaclasse.Create;
    TousEmployesAnim := TFloatAnimation.Create(nil);
    animTout(TousEmployesAnim, classeEvent.FinishTousEmploye);
end;

procedure TMaClasse.FinishTousEmploye(Sender: TObject);
begin
   TousEmployesAnim.Enabled := False;
   TousEmployesAnim.Free;
end;

// Pour le topElementFdp Fiche de pointage

procedure appaTopElementFdp();
begin
    classeEvent := TMaclasse.Create;
    TopElementFdpAnim := TFloatAnimation.Create(nil);
    animTout(TopElementFdpAnim, classeEvent.FinishTopElementFdpAnim);
end;

procedure TMaclasse.FinishTopElementFdpAnim(Sender: TObject);
begin
   TopElementFdpAnim.Enabled := False;
   TopElementFdpAnim.Free;
end;

// Tous les employés fiche de pointage

procedure appaTousEmployeFdp();
begin
   classeEvent := TMaclasse.Create;
   TousEmployeFdpAnim := TFloatAnimation.Create(nil);
   animTout(TousEmployeFdpAnim, classeEvent.FinishTousElementFdpAnim);
end;

procedure TMaclasse.FinishTousElementFdpAnim(Sender: TObject);
begin
  TousEmployeFdpAnim.Enabled := False;
  TousEmployeFdpAnim.Free;
end;

// Pour le top element Evaluation



procedure appaTopElementEval ();
begin
    classeEvent := TMaclasse.Create;
    TopElementEvalAnim := TFloatAnimation.Create(nil);
    animTout(TopElementEvalAnim, classeEvent.FinishTopElementEvalAnim);
end;

procedure TMaclasse.FinishTopElementEvalAnim(Sender: TObject);
begin
  TopElementEvalAnim.Enabled := False;
  TopElementEvalAnim.Free;
end;

// pour tous les employé Evaluation

procedure appaTousEmployesEval ();
begin
  classeEvent := TMaclasse.Create;
  TousEmployeEvalAnim := TFloatAnimation.Create(nil);
  animTout(TousEmployeEvalAnim, classeEvent.FinishTousEmployeEval);
end;

procedure TMaclasse.FinishTousEmployeEval(Sender: TObject);
begin
  TousEmployeEvalAnim.Enabled := False;
  TousEmployeEvalAnim.Free;
end;


// Pour le top Element congé

procedure appaTopElementConge ();
begin
  classeEvent := TMaclasse.Create;
  TopElementCongeAnim := TFloatAnimation.Create(nil);
  animTout(TopElementCongeAnim, classeEvent.FinishTopElementCongeAnim);
end;

procedure TMaclasse.FinishTopElementCongeAnim(Sender: TObject);
begin
  TopElementCongeAnim.Enabled := False;
  TopElementCongeAnim.Free;
end;

// Pour tous les employés Congé

procedure appaTousEmployesConge ();
begin
  classeEvent := TMaclasse.Create;
  TousEmployeCongeAnim := TFloatAnimation.Create(nil);
  animTout(TousEmployeCongeAnim, classeEvent.FinishTousEmployeConge);
end;

procedure TMaclasse.FinishTousEmployeConge(Sender: TObject);
begin
  TousEmployeCongeAnim.Enabled := False;
  TousEmployeCongeAnim.Free;
end;


function elementSect (tabFiltre :  TtabFiltreType) : TtabFiltreSelect;
 var
    i : Integer;
    j : Integer;
    tailleTabFiltre : Integer;
    elementSelect : TtabFiltreSelect;
 begin
      j := 0;
      tailleTabFiltre := Length(tabFiltre);
     for i := 0 to tailleTabFiltre-1 do
         begin
           if tabFiltre[i].nomFilter <> '' then
              begin
                 j := j + 1;
              end;
         end;
     SetLength(elementSelect, j);

     // Reinitialisation

     j := 0;

     for i := 0 to tailleTabFiltre-1 do
         begin
            if tabFiltre[i].nomFilter <> '' then
              begin
                 elementSelect [j] := tabFiltre[i].nomFilter;
                 j := j + 1;
              end;
         end;
     Result := elementSelect;
 end;

 // Fiche de Pointage


end.
