unit FrCandidatTopElement;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Ani, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.Effects;

type
  TcandidatTopElement = class(TFrame)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Label1: TLabel;
    ColorAnimation1: TColorAnimation;
    ShadowEffect1: TShadowEffect;
    procedure Rectangle1MouseEnter(Sender: TObject);
    procedure Rectangle1MouseLeave(Sender: TObject);
    procedure ColorAnimation1Process(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}


procedure TcandidatTopElement.ColorAnimation1Process(Sender: TObject);
begin
  ShadowEffect1.ShadowColor := ColorAnimation1.StopValue;
end;

procedure TcandidatTopElement.Rectangle1MouseEnter(Sender: TObject);
begin
  Label1.FontColor := TAlphaColorRec.Black;
end;

procedure TcandidatTopElement.Rectangle1MouseLeave(Sender: TObject);
begin
  label1.FontColor := TAlphaColorRec.White;
end;

end.
