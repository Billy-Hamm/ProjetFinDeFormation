unit FrEvaluationClickContainer;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts;

type
  TevaluationClickContrainer = class(TFrame)
    evalClickContain: TLayout;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

// La taille du layout que doit contenir le clic sur un employeEval
// pour faire l'évaluation est : 450 x 339

end.
