unit FrConge;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FrEmployeMaquetteConge,
  FrCongeClick, FMX.Ani;

type
  Tconge = class(TFrame)
    titreListeEmploye: TRectangle;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    topListeEmploye: TRectangle;
    Label12: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    VertScrollBox1: TVertScrollBox;
    containeTitreConge: TLayout;
    conteneurFiltre: TLayout;
    appaConteneurFiltre: TFloatAnimation;
    dispConteneurFiltre: TFloatAnimation;
    procedure appaConteneurFiltreFinish(Sender: TObject);
    procedure dispConteneurFiltreFinish(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

procedure Tconge.appaConteneurFiltreFinish(Sender: TObject);
begin
appaConteneurFiltre.Enabled := False;
end;

procedure Tconge.dispConteneurFiltreFinish(Sender: TObject);
begin
dispConteneurFiltre.Enabled := False;
end;

end.
