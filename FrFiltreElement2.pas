unit FrFiltreElement2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts;

type
  TFiltreElement2 = class(TFrame)
    CalloutRectangle1: TCalloutRectangle;
    body: TVertScrollBox;
    Layout1: TLayout;
    val: TRectangle;
    Line1: TLine;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

end.
