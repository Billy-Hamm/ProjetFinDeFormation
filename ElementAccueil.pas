unit ElementAccueil;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Ani, FMX.Layouts, FMX.Controls.Presentation;

type
  TFrElementAccueil = class(TFrame)
    Rectangle1: TRectangle;
    Circle1: TCircle;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    FlowLayout1: TFlowLayout;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

end.
