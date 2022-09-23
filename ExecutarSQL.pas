unit ExecutarSQL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Tabs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.VCLUI.ConnEdit, FireDAC.Phys.FB, FireDAC.Phys.FBDef;

type
  TfmExecutarSQL = class(TForm)
    pnBancoAberto: TPanel;
    pnBotoes: TPanel;
    mmSQL: TMemo;
    bExecutar: TBitBtn;
    pcQuery: TPageControl;
    tsSQL: TTabSheet;
    tsResultado: TTabSheet;
    FDConn: TFDConnection;
    FDQuery: TFDQuery;
    DataSource: TDataSource;
    bAbrirBD: TBitBtn;
    dbgResultado: TDBGrid;
    bRegistrar: TBitBtn;
    procedure bAbrirBDClick(Sender: TObject);
    procedure bExecutarClick(Sender: TObject);
    procedure bRegistrarClick(Sender: TObject);
  private
    procedure AbrirConexao;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmExecutarSQL: TfmExecutarSQL;

implementation

{$R *.dfm}

uses BancosRegistrados;

//   FDConn.GetLastAutoGenValue('NFCNFEID');
procedure TfmExecutarSQL.AbrirConexao;
begin
   FDConn.LoginPrompt := FDConn.Params.Password = '';
   FDConn.Open;
   pnBancoAberto.Caption := FDConn.Params.Database;
   pcQuery.ActivePage := tsSQL;
   mmSQL.SetFocus;
end;

procedure TfmExecutarSQL.bAbrirBDClick(Sender: TObject);
begin
   FDConn.Params.Assign(fmBancosRegistrados.ObterBanco);
   AbrirConexao;
end;

procedure TfmExecutarSQL.bExecutarClick(Sender: TObject);
begin
   if FDConn.Connected and (mmSQL.Lines.Text <> '') then
      FDQuery.Open(mmSQL.Lines.Text);
   if FDQuery.Active then
      pcQuery.ActivePage := tsResultado;
end;

procedure TfmExecutarSQL.bRegistrarClick(Sender: TObject);
begin
   if TfrmFDGUIxFormsConnEdit.Execute(FDConn,FDConn.Name) then
   begin
      fmBancosRegistrados.RegistrarObterBanco(FDConn.Params);
      AbrirConexao;
   end;
end;

end.
