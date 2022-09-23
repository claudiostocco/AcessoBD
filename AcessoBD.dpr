program AcessoBD;

uses
  Vcl.Forms,
  ExecutarSQL in 'ExecutarSQL.pas' {fmExecutarSQL},
  BancosRegistrados in 'BancosRegistrados.pas' {fmBancosRegistrados};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmExecutarSQL, fmExecutarSQL);
  Application.CreateForm(TfmBancosRegistrados, fmBancosRegistrados);
  Application.Run;
end.
