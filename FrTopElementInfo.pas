unit FrTopElementInfo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts;

type
  TtopElementInfo = class(TFrame)
    container: TLayout;
    valInfo: TLayout;
    valPeriode: TLabel;
    valJrOuvrable: TLabel;
    valDate: TLabel;
    info: TLayout;
    periode: TLabel;
    jrOuvrable: TLabel;
    date: TLabel;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

end.
