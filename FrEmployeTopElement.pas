unit FrEmployeTopElement;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Ani, FMX.Effects, FMX.Layouts;

type
  TemployeTopElemnt = class(TFrame)
    Rectangle8: TRectangle;
    Label12: TLabel;
    ColorAnimation1: TColorAnimation;
    ShadowEffect1: TShadowEffect;
    Layout1: TLayout;
    procedure Rectangle8MouseEnter(Sender: TObject);
    procedure Rectangle8MouseLeave(Sender: TObject);
    procedure ColorAnimation1Process(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }

  end;

implementation
{$R *.fmx}

procedure TemployeTopElemnt.ColorAnimation1Process(Sender: TObject);
begin
  ShadowEffect1.ShadowColor := ColorAnimation1.StopValue; //pour faire en sorte a ce qu'elle prenne directement la meme couleur que celle dont elle projette l'ombre pour un effet "d'illumination".
end;

procedure TemployeTopElemnt.Rectangle8MouseEnter(Sender: TObject);
begin
//  Label12.FontColor := random(TAlphaColorRec.green);
  Label12.FontColor := TAlphaColorRec.Black;
end;


procedure TemployeTopElemnt.Rectangle8MouseLeave(Sender: TObject);

//  var CouleurActuelle : TColor;

begin
  Label12.FontColor := TAlphaColorRec.White;
//  CouleurActuelle := Label12.FontColor;
//  Label12.FontColor := CouleurActuelle;
end;

end.
