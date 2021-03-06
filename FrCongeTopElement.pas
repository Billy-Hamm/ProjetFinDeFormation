unit FrCongeTopElement;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.Effects;

type
  TcongeTopElement = class(TFrame)
    titreConge: TLabel;
    Rectangle1: TRectangle;
    Layout1: TLayout;
    ShadowEffect1: TShadowEffect;
    procedure Rectangle1MouseEnter(Sender: TObject);
    procedure Rectangle1MouseLeave(Sender: TObject);
  private
    { D?clarations priv?es }
  public
    { D?clarations publiques }
  end;

implementation

{$R *.fmx}
  Var ClRecDft : TColor; //cela nous permettera de changer la couleur du rectangle en conception sans la changer en code(plus de fl?xibilit?).
      ClTxtDft : Tcolor;
procedure TcongeTopElement.Rectangle1MouseEnter(Sender: TObject);
begin
  ClRecDft := Rectangle1.Fill.Color;  //pour Enregistrer la couleur que nos avons definie pour le rectangle.
  ClTxtDft := titreConge.FontColor;   //pour enregistrer la couleur que nos avons definie pour le texte.
  Rectangle1.Fill.Color := ($FF31976F); //Assigner une nouvelle couleur ? l'entr?e de la souris.
  titreConge.FontColor := TAlphaColorRec.Black;
  ShadowEffect1.ShadowColor := Rectangle1.Fill.Color;
end;

procedure TcongeTopElement.Rectangle1MouseLeave(Sender: TObject);
begin
  Rectangle1.Fill.Color :=  ClRecDft;
  titreConge.FontColor := ClTxtDft;
  //Rectangle1.Fill.Color := ($FFE0E0E0); //ce code l? restreint un peu les possibilit?s et limite l'utilisateur, c'est pour ?a qu'il vaut mieux definir une couleur par defaut(CouleurDef) vers la quelle retourner.
end;

end.
