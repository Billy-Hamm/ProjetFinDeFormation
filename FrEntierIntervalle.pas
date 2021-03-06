unit FrEntierIntervalle;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.ListBox, FMX.Controls.Presentation, FMX.Edit, FMX.Effects,
  FMX.Layouts;

type
  TentierIntervalle = class(TFrame)
    critere1: TEdit;
    CBOperations: TComboBox;
    RectCrit1: TRectangle;
    lblIntervalle: TLabel;
    containerIntervalle: TLayout;
    libelleCritere: TLabel;
    RectCritStr: TRectangle;
    critStr: TEdit;
    btnDestroy: TCircle;
    Label2: TLabel;
    ShadowEffect1: TShadowEffect;
    rectCrit2: TRectangle;
    critere2: TEdit;
    procedure CBOperationsChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

procedure TentierIntervalle.CBOperationsChange(Sender: TObject);
begin
if CBOperations.ItemIndex = 0 then
   begin
     CBOperations.ItemIndex := -1;
   end;
end;

end.
