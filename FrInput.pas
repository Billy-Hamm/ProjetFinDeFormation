unit FrInput;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Ani, FMX.Edit, FMX.Controls.Presentation;

type
  Tinput = class(TFrame)
    Edit1: TEdit;
    Label1: TLabel;
    Line1: TLine;
    AnimIn: TFloatAnimation;
    AnimInverse: TFloatAnimation;
    procedure Edit1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
//   procedure AnimInFinish(Sender: TObject);
//    procedure posAnimFinish(Sender: TObject);
//    procedure posAnimInversFinish(Sender: TObject);
//    procedure Edit1Enter(Sender: TObject);
//    procedure Edit1Exit(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

//procedure Tinput.Edit1Enter(Sender: TObject);
//begin
//if Edit1.Text = '' then
//posAnim.Enabled := True;
//end;

//procedure Tinput.Edit1Exit(Sender: TObject);
//begin
//if Edit1.Text = '' then
//posAnimInvers.Enabled := True;
//end;
//
//procedure Tinput.posAnimFinish(Sender: TObject);
//begin
//posAnim.Enabled := False;
//end;
//
//procedure Tinput.posAnimInversFinish(Sender: TObject);
//begin
//posAnimInvers.Enabled := False;
//end;

procedure Tinput.Edit1Click(Sender: TObject);
begin
  AnimIn.Enabled := true;
  AnimInverse.Enabled := false;
  Label1.Font.Size := 12;
  Label1.FontColor := $FF1FAB4B;    //vert texte
  Line1.Stroke.Color := $FF1FAB4B;  //vert texte
end;


procedure Tinput.Edit1Exit(Sender: TObject);
begin
  if Edit1.Text = '' then
    begin
      AnimInverse.Enabled := true;
        Label1.Font.Size := 14;
        Label1.FontColor := $FF040404;   //noir
        Line1.Stroke.Color := $FF040404; //noir
      AnimIn.Enabled := false;
    end;
end;

end.
