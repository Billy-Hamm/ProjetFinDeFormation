unit recherchePopupEmp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.Ani;

type
  TFrRecherchePopupEmp = class(TFrame)
    Rectangle1: TRectangle;
    LayoutTop: TLayout;


  private
    { Déclarations privées }
  public
  Var LblClDef : TAlphaColor;
      LblTlDef : Single;
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}



end.
