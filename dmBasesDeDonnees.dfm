object basesDeDonnees: TbasesDeDonnees
  OldCreateOrder = False
  Height = 269
  Width = 517
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=essaie'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 8
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 123
    Top = 8
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\mdfgestsymp\baseDeDonnees\symp.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Transaction = FDTransaction1
    Left = 32
    Top = 192
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 120
    Top = 192
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Transaction = FDTransaction1
    Left = 189
    Top = 192
  end
  object FDConnection2: TFDConnection
    Params.Strings = (
      'Database=C:\mdfgestsymp\baseDeDonnees\JOINTURE.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Transaction = FDTransaction2
    Left = 336
    Top = 16
  end
  object FDTransaction2: TFDTransaction
    Connection = FDConnection2
    Left = 400
    Top = 40
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection2
    Transaction = FDTransaction2
    Left = 464
    Top = 16
  end
  object ADOStoredProc1: TADOStoredProc
    Connection = ADOConnection1
    ProcedureName = 'empPointablePasPointer;1'
    Parameters = <>
    Left = 64
    Top = 64
  end
end
