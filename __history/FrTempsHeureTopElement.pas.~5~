unit FrTempsHeureTopElement;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.DateTimeCtrls, FMX.Controls.Presentation, FMX.Objects, FMX.Edit,
  FMX.Layouts, FMX.Ani;

type
  TtempsTopElement = class(TFrame)
    Image1: TImage;
    Rectangle1: TRectangle;
    texteFilter: TLabel;
    dateDebut: TDateEdit;
    dateFin: TDateEdit;
    conteneurTemps: TLayout;
    conteneurHeure: TLayout;
    Rectangle2: TRectangle;
    Image2: TImage;
    Label2: TLabel;
    Rectangle3: TRectangle;
    Label6: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    heureArrive: TRectangle;
    Label5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    depTemps: TFloatAnimation;
    opTemps: TFloatAnimation;
    depTempsInv: TFloatAnimation;
    opTempsInv: TFloatAnimation;
    depHeure: TFloatAnimation;
    opHeure: TFloatAnimation;
    depHeureInv: TFloatAnimation;
    opHeureInv: TFloatAnimation;
    procedure opTempsFinish(Sender: TObject);
    procedure depTempsFinish(Sender: TObject);
    procedure depTempsInvFinish(Sender: TObject);
    procedure opTempsInvFinish(Sender: TObject);
    procedure depHeureFinish(Sender: TObject);
    procedure depHeureInvFinish(Sender: TObject);
    procedure opHeureFinish(Sender: TObject);
    procedure opHeureInvFinish(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

procedure TtempsTopElement.depHeureFinish(Sender: TObject);
begin
depHeure.Enabled := False;
end;

procedure TtempsTopElement.depHeureInvFinish(Sender: TObject);
begin
depHeureInv.Enabled := False;
end;

procedure TtempsTopElement.depTempsFinish(Sender: TObject);
begin
depTemps.Enabled := False;
end;

procedure TtempsTopElement.depTempsInvFinish(Sender: TObject);
begin
depTempsInv.Enabled := False;
end;

procedure TtempsTopElement.opHeureFinish(Sender: TObject);
begin
opHeure.Enabled := False;
end;

procedure TtempsTopElement.opHeureInvFinish(Sender: TObject);
begin
opHeureInv.Enabled := False;
conteneurHeure.Visible := False;
end;

procedure TtempsTopElement.opTempsFinish(Sender: TObject);
begin
opTemps.Enabled := False;
conteneurTemps.Visible := False;
end;

procedure TtempsTopElement.opTempsInvFinish(Sender: TObject);
begin
opTempsInv.Enabled := False;
end;

end.
