unit FrFiltreMaquetteClickFdp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts;

type
  TfiltreMaquetteClickFdp = class(TFrame)
    containerFiltreFdp: TLayout;
    Line1: TLine;
    containerTitreFiltreFdp: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    performanceEmploye: TLabel;
    posteEmploye: TLabel;
    identifiant: TLabel;
    Layout1: TLayout;
    Rectangle4: TRectangle;
    CheckBox2: TCheckBox;
    Rectangle3: TRectangle;
    Label6: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    heureArrive: TRectangle;
    Label5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    CheckBox1: TCheckBox;
    Rectangle2: TRectangle;
    Label7: TLabel;
    Label4: TLabel;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

end.
