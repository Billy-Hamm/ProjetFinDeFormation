unit FrTacheMaquette;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.DateTimeCtrls,
  FMX.Effects;

type
  TtacheMaquette = class(TFrame)
    tache: TRectangle;
    titreTache: TLabel;
    barreProgression: TRectangle;
    Circle1: TCircle;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Circle2: TCircle;
    progressItem: TRectangle;
    ShadowEffect1: TShadowEffect;
    Label4: TLabel;
    procedure tacheMouseEnter(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

procedure TtacheMaquette.tacheMouseEnter(Sender: TObject);
begin
//  tache.Fill.Color := random($FFCC8080); //Fct Boite de nuit
end;

end.
