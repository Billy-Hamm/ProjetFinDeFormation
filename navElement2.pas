unit navElement2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Ani, FMX.Effects, FMX.Controls.Presentation, FMX.Objects,
  FMX.Filter.Effects;

type
  TFrNavElement2 = class(TFrame)
    Rectangle1: TRectangle;
    Label1: TLabel;
    ColorAnimation1: TColorAnimation;
    ShadowEffect1: TShadowEffect;
    InvertEffect1: TInvertEffect;
    procedure Rectangle1MouseLeave(Sender: TObject);
    procedure Rectangle1MouseEnter(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;


implementation

{$R *.fmx}



procedure TFrNavElement2.Rectangle1MouseEnter(Sender: TObject);
begin
  InvertEffect1.Enabled := true;
end;

procedure TFrNavElement2.Rectangle1MouseLeave(Sender: TObject);
begin
  InvertEffect1.Enabled := false;
end;


end.
