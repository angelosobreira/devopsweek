unit Factory.Connection;

interface

uses FireDAC.Comp.Client;

type
  TConnectionFactory = class
  public
    class function Connection : TFDConnection;
  end;



implementation

{ TConnectionFactory }

uses Factory.FDConnection;

class function TConnectionFactory.Connection: TFDConnection;
begin
  Result := TFDConnectionFactory.Connection;
end;

end.
