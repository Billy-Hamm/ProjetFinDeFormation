unit FrPopUpRechEmp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FrInput;

type
  TPopUpRechEmp = class(TFrame)
    Rectangle1: TRectangle;
    VertScrollBox1: TVertScrollBox;
    input2: Tinput;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

end.
