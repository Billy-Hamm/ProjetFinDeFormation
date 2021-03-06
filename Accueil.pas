unit Accueil;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Ani, FMX.Effects, ElementAccueil,
  FMX.Controls.Presentation;

type
  TFrAccueil = class(TFrame)
    Rectangle2: TRectangle;
    FlowLayout1: TFlowLayout;
    FlowLayout2: TFlowLayout;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    ColorAnimation1: TColorAnimation;
    ColorAnimation2: TColorAnimation;
    ColorAnimation3: TColorAnimation;
    ColorAnimation4: TColorAnimation;
    ColorAnimation5: TColorAnimation;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    ShadowEffect5: TShadowEffect;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    FloatAnimation3: TFloatAnimation;
    FloatAnimation4: TFloatAnimation;
    FloatAnimation5: TFloatAnimation;
    VertScrollBox1: TVertScrollBox;
    VertScrollBox3: TVertScrollBox;
    VertScrollBox4: TVertScrollBox;
    VertScrollBox5: TVertScrollBox;
    Rectangle1: TRectangle;
    FrElementAccueil1: TFrElementAccueil;
    nomMenuEmp: TRectangle;
    texteMenuEmp: TLabel;
    animEntreeMenuEmp: TFloatAnimation;
    animSortieMenuEmp: TFloatAnimation;
    nomMenuOmbre: TShadowEffect;
    procedure Rectangle1MouseEnter(Sender: TObject);
    procedure Rectangle1MouseLeave(Sender: TObject);
    procedure animSortieMenuEmpFinish(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

uses dmBasesDeDonnees;

procedure TFrAccueil.animSortieMenuEmpFinish(Sender: TObject);
begin
  nomMenuEmp.visible := false;
end;


procedure TFrAccueil.Rectangle1MouseEnter(Sender: TObject);
begin
  nomMenuEmp.visible := true;
  Rectangle1 := nomMenuEmp;
  animEntreeMenuEmp.Enabled := true;
  animSortieMenuEmp.enabled := false;
  nomMenuOmbre.Enabled := true;
end;

procedure TFrAccueil.Rectangle1MouseLeave(Sender: TObject);
begin
  nomMenuOmbre.Enabled := false;
  animEntreeMenuEmp.Enabled := false;
  animSortieMenuEmp.enabled := true;
end;

end.
