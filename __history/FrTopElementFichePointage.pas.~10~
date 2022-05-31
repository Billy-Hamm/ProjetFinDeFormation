unit FrTopElementFichePointage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Objects, FrTempsHeureTopElement;

type
  TtopElementFdp = class(TFrame)
    boutonValidation: TRectangle;
    Label1: TLabel;
    conteneurTopTemps: TLayout;
    posisTop: TCircle;
    Line1: TLine;
    Line2: TLine;
    posisDroite: TRectangle;
    posisGauche: TRectangle;
    Line3: TLine;
    Line4: TLine;
    changePosis: TCircle;
    procedure ajoutTempsHeure ();
    procedure changePosisClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

  //Procedures

  // Variables
var
  tempsHeure : TtempsTopElement;
  toogleAnim : Boolean;

implementation

{$R *.fmx}

procedure TtopElementFdp.ajoutTempsHeure();
begin
  tempsHeure := TtempsTopElement.Create(Self);
  tempsHeure.Parent := conteneurTopTemps;
end;

procedure TtopElementFdp.changePosisClick(Sender: TObject);
begin
   if toogleAnim = False then
     begin
      toogleAnim := True;
       with tempsHeure do
         begin
           conteneurHeure.Visible := True;
           depTemps.Enabled := True;
           opTemps.Enabled := True;
           depHeure.Enabled := True;
           opHeure.Enabled := True;
         end;
     end
     else
       begin
        toogleAnim := False;
         with tempsHeure do
         begin
           conteneurTemps.Visible := True;
           depHeureInv.Enabled := True;
           opHeureInv.Enabled := True;
           depTempsInv.Enabled := True;
           opTempsInv.Enabled := True;
         end;
       end;
end;

end.
