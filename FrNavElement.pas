unit FrNavElement;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Effects, FMX.Ani, FMX.Controls.Presentation, FMX.Objects, varGlobale,
  FMX.Filter.Effects;


var
  routeActuelle : string;
  routeAncienne : string;


type
  TelementNav = class(TFrame)
    elementNagivation: TRectangle;
    Label1: TLabel;
    ColorAnimation1: TColorAnimation;
    ShadowEffect1: TShadowEffect;
    InvertEffect1: TInvertEffect;
//    procedure opakFinish(Sender: TObject);
//    procedure opakInversFinish(Sender: TObject);
//    procedure colorInFinish(Sender: TObject);
//    procedure colorOutFinish(Sender: TObject);
    procedure elementNagivationMouseEnter(Sender: TObject);
    procedure elementNagivationMouseLeave(Sender: TObject);
    procedure elementNagivationClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;




implementation

{$R *.fmx}

//procedure TelementNav.colorInFinish(Sender: TObject);
//begin
//  colorIn.Enabled := False;
//end;


//procedure TelementNav.colorOutFinish(Sender: TObject);
//begin
//  colorOut.Enabled := False;
//end;

//procedure TelementNav.opakFinish(Sender: TObject);
//begin
//  opak.Enabled := False;
//end;


// Chargement dynamique des composant
procedure TelementNav.elementNagivationClick(Sender: TObject);
begin
  routeActuelle := Label1.Text;
  retirerElement (routeAncienne);
  ajouterElement (routeActuelle);
  routeAncienne := routeActuelle;
end;

procedure TelementNav.elementNagivationMouseEnter(Sender: TObject);
begin
  InvertEffect1.Enabled := true;
//  colorIn.Enabled := True;
//  opak.Enabled := True;
//  ombre.Enabled := True;
end;

procedure TelementNav.elementNagivationMouseLeave(Sender: TObject);
begin
  InvertEffect1.Enabled := false;
//  colorOut.Enabled := True;
//  opakInvers.Enabled := True;
//  ombre.Enabled := False;
end;



end.
