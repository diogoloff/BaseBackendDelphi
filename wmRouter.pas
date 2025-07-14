unit wmRouter;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker, Datasnap.DSServer,
  Web.WebFileDispatcher, Web.HTTPProd,
  DataSnap.DSAuth,
  Datasnap.DSProxyJavaScript, IPPeerServer, Datasnap.DSMetadata,
  Datasnap.DSServerMetadata, Datasnap.DSClientMetadata, Datasnap.DSCommonServer,
  Datasnap.DSHTTP;

type
  TRouter = class(TWebModule)
    DSRESTWebDispatcher1: TDSRESTWebDispatcher;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TRouter;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses smUsuarios, scServer, Web.WebReq;

procedure TRouter.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content :=
    '<html>' +
    '<head><title>DataSnap Server</title></head>' +
    '<body>DataSnap Server</body>' +
    '</html>';
end;

procedure TRouter.WebModuleBeforeDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  Param: string;
  ServerMethods: TUsuarios;
begin
  if SameText(Request.PathInfo, '/usuarios/echostring/') then
  begin
    Param := Request.QueryFields.Values['param'];
    ServerMethods := TUsuarios.Create(nil);
    try
      Response.Content := Format('{"resultado":"%s"}', [ServerMethods.EchoString(Param)]);
      Response.ContentType := 'application/json';
      Handled := True;
    finally
      ServerMethods.Free;
    end;
  end;
end;

procedure TRouter.WebModuleCreate(Sender: TObject);
begin
  DSRESTWebDispatcher1.Server := DSServer;
  if DSServer.Started then
  begin
    DSRESTWebDispatcher1.DbxContext := DSServer.DbxContext;
    DSRESTWebDispatcher1.Start;
  end;
end;

initialization
finalization
  Web.WebReq.FreeWebModules;

end.

