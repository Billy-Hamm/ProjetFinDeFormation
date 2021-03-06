unit Checkbox;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox, System.ImageList,
  FMX.ImgList, FMX.Menus, FMX.Edit, FMX.EditBox, FMX.ComboTrackBar;

type
  TFrCheckbox = class(TFrame)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Layout1: TLayout;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    GroupBox1: TGroupBox;
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure CheckBox5Change(Sender: TObject);
    procedure CheckBox6Change(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

procedure TFrCheckbox.CheckBox1Change(Sender: TObject);
begin
  if CheckBox1.IsChecked = true then
    begin
      CheckBox2.IsChecked := false;
      CheckBox3.IsChecked := false;
      CheckBox4.IsChecked := false;
      CheckBox5.IsChecked := false;
      CheckBox6.IsChecked := false;
    end;
end;

procedure TFrCheckbox.CheckBox2Change(Sender: TObject);
begin
    if CheckBox2.IsChecked = true then
    begin
      CheckBox1.IsChecked := false;
      CheckBox3.IsChecked := false;
      CheckBox4.IsChecked := false;
      CheckBox5.IsChecked := false;
      CheckBox6.IsChecked := false;
    end;
end;

procedure TFrCheckbox.CheckBox3Change(Sender: TObject);
begin
  if CheckBox3.IsChecked = true then
    begin
      CheckBox2.IsChecked := false;
      CheckBox1.IsChecked := false;
      CheckBox4.IsChecked := false;
      CheckBox5.IsChecked := false;
      CheckBox6.IsChecked := false;
    end;
end;

procedure TFrCheckbox.CheckBox4Change(Sender: TObject);
begin
  if CheckBox4.IsChecked = true then
    begin
      CheckBox2.IsChecked := false;
      CheckBox3.IsChecked := false;
      CheckBox1.IsChecked := false;
      CheckBox5.IsChecked := false;
      CheckBox6.IsChecked := false;
    end;
end;

procedure TFrCheckbox.CheckBox5Change(Sender: TObject);
begin
  if CheckBox5.IsChecked = true then
    begin
      CheckBox2.IsChecked := false;
      CheckBox3.IsChecked := false;
      CheckBox4.IsChecked := false;
      CheckBox1.IsChecked := false;
      CheckBox6.IsChecked := false;
    end;
end;

procedure TFrCheckbox.CheckBox6Change(Sender: TObject);
begin
  if CheckBox6.IsChecked = true then
    begin
      CheckBox2.IsChecked := false;
      CheckBox3.IsChecked := false;
      CheckBox4.IsChecked := false;
      CheckBox5.IsChecked := false;
      CheckBox1.IsChecked := false;
    end;
end;

end.
