unit FrAbsenceTopElement;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.Effects,
  FMX.Filter.Effects, FMX.Ani;

type
  TabsenceTopElement = class(TFrame)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    ShadowEffect1: TShadowEffect;
    Label1: TLabel;
    ColorAnimation1: TColorAnimation;
    InvertEffect2: TInvertEffect;
    procedure Rectangle1MouseEnter(Sender: TObject);
    procedure Rectangle1MouseLeave(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

procedure TabsenceTopElement.Rectangle1MouseEnter(Sender: TObject);
begin
  //  InvertEffect2.Enabled := True;
  Label1.FontColor := TAlphaColorRec.Red;
end;

procedure TabsenceTopElement.Rectangle1MouseLeave(Sender: TObject);
begin
//  InvertEffect2.Enabled := False;
  Label1.FontColor := TAlphaColorRec.White;
end;

end.
