unit Factory.FDConnection;

interface

uses FireDAC.Comp.Client,
  FireDAC.Phys.SQLite,
  MVCFramework.SQLGenerators.Sqlite;

type
  TFDConnectionFactory = class
  public
    class function Connection : TFDConnection;
  end;

implementation

{ TFDConnectionFactory }

class function TFDConnectionFactory.Connection: TFDConnection;
begin
  Result := TFDConnection.Create(nil);
  Result.Params.Clear;
  Result.Params.Database := 'activerecorddb.db';
  Result.DriverName := 'SQLite';
  Result.Connected := True;
end;

end.
