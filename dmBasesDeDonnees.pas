unit dmBasesDeDonnees;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.DB, Data.Win.ADODB,
  System.ImageList, FMX.ImgList;

type
  TbasesDeDonnees = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    FDConnection1: TFDConnection;
    FDTransaction1: TFDTransaction;
    FDQuery1: TFDQuery;
    FDConnection2: TFDConnection;
    FDTransaction2: TFDTransaction;
    FDQuery2: TFDQuery;
    ADOStoredProc1: TADOStoredProc;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  basesDeDonnees: TbasesDeDonnees;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
