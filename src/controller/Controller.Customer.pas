unit Controller.Customer;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons,
  MVCFramework.ActiveRecord,
  System.Generics.Collections,
  System.JSON,
  FireDAC.Comp.Client;

type

  [MVCPath('/api')]
  TCustomerController = class(TMVCController)
  private
    FDConn : TFDConnection;

  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;

  public
    //Sample CRUD Actions for a "Customer" entity
    [MVCPath('/customers')]
    [MVCHTTPMethod([httpGET])]
    procedure GetCustomers;

    [MVCPath('/customers/($id)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetCustomer(id: Integer);

    [MVCPath('/customers')]
    [MVCHTTPMethod([httpPOST])]
    procedure CreateCustomer;

    [MVCPath('/customers/($id)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateCustomer(id: Integer);

    [MVCPath('/customers/($id)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteCustomer(id: Integer);

    constructor Create; override;
    destructor Destroy;override;

  end;

implementation

uses
  System.SysUtils, MVCFramework.Logger, System.StrUtils, Factory.Connection,
  Model.Customer;

procedure TCustomerController.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
  { Executed after each action }
  inherited;
end;

procedure TCustomerController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  { Executed before each action
    if handled is true (or an exception is raised) the actual
    action will not be called }
  inherited;
end;

procedure TCustomerController.GetCustomers;
var
  LCustomer : TObjectList<TCustomer>;
begin
  LCustomer := TMVCActiveRecord.All<TCustomer>;

  Render<TCustomer>(LCustomer);
end;

procedure TCustomerController.GetCustomer(id: Integer);
var
  LCustomer : TCustomer;
begin
  LCustomer := TMVCActiveRecord.GetByPK<TCustomer>(id);

  Render(LCustomer);
end;

constructor TCustomerController.Create;
begin
  inherited;
  FDConn := TConnectionFactory.Connection;
  ActiveRecordConnectionsRegistry.AddDefaultConnection(FDConn);
end;

procedure TCustomerController.CreateCustomer;
var
  LCustomer : TCustomer;
begin
  LCustomer := Context.Request.BodyAs<TCustomer>;

  LCustomer.Insert;
  Render(LCustomer);
end;

procedure TCustomerController.UpdateCustomer(id: Integer);
var
  LCustomer : TCustomer;
begin
  LCustomer := Context.Request.BodyAs<TCustomer>;
  LCustomer.id := id;

  LCustomer.Update;
  Render(LCustomer);
end;

procedure TCustomerController.DeleteCustomer(id: Integer);
var
  LCustomer : TCustomer;
begin
  LCustomer := TMVCActiveRecord.GetByPK<TCustomer>(id);
  LCustomer.Delete;

  Render(TJSONObject.Create(TJSONPair.Create('result', 'customer deleted')));
end;

destructor TCustomerController.Destroy;
begin
  ActiveRecordConnectionsRegistry.RemoveDefaultConnection;
  FDConn.Free;
  inherited;
end;

end.
