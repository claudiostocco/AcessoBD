unit BancosRegistrados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf, IniFiles, Vcl.Menus,
  FireDAC.Comp.Client, FireDAC.VCLUI.ConnEdit, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Phys.FB, FireDAC.Phys.FBDef;

type
  TfmBancosRegistrados = class(TForm)
    lbBancos: TListBox;
    PopupMenu1: TPopupMenu;
    mEditarCnx: TMenuItem;
    FDCn: TFDConnection;
    procedure FormCreate(Sender: TObject);
    procedure mEditarCnxClick(Sender: TObject);
    procedure lbBancosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lbBancosMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure lbBancosDblClick(Sender: TObject);
  private
    Ini: TIniFile;
    procedure RegistrarBanco(Params: TFDConnectionDefParams);
    procedure GravaArquivoIni(SectionName: String; Params: TFDConnectionDefParams);
  public
    function RegistrarObterBanco(Params: TFDConnectionDefParams): TFDConnectionDefParams;
    function ObterBanco: TFDConnectionDefParams;
    { Public declarations }
  end;

var
  fmBancosRegistrados: TfmBancosRegistrados;

implementation

{$R *.dfm}

{ TfmBancosRegistrados }

procedure TfmBancosRegistrados.FormCreate(Sender: TObject);
var
  i: Integer;
  Params: TStrings;
begin
   Ini := TIniFile.Create(ParamStr(0).Replace(ExtractFileExt(ParamStr(0)),'.ini',[]));
   for i := 0 to 20 do
   begin
      if Ini.SectionExists(i.ToString) then
      begin
         Params := TStringList.Create;
         Ini.ReadSectionValues(i.ToString,Params);
//         TFDConnectionDefParams
         lbBancos.AddItem(Params.Values['Database'],TFDConnectionDefParams(Params));
      end else
         Break;
   end;
   if lbBancos.Count > 0 then lbBancos.ItemIndex := 0;
end;

procedure TfmBancosRegistrados.GravaArquivoIni(SectionName: String; Params: TFDConnectionDefParams);
var
  i: Integer;
begin
   for i := 0 to Params.Count - 1 do
      Ini.WriteString(SectionName,Params.Names[i],Params.ValueFromIndex[i]);
end;

procedure TfmBancosRegistrados.lbBancosDblClick(Sender: TObject);
begin
   Close;
end;

procedure TfmBancosRegistrados.lbBancosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_RETURN then Close;
   if Key = VK_ESCAPE then
   begin
      lbBancos.ItemIndex := -1;
      Close;
   end;
end;

procedure TfmBancosRegistrados.lbBancosMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if Button = TMouseButton.mbRight then
      PopupMenu1.Popup(Left+X,Top+Y);
end;

procedure TfmBancosRegistrados.mEditarCnxClick(Sender: TObject);
begin
   if (lbBancos.ItemIndex > -1) and (lbBancos.Items.Objects[lbBancos.ItemIndex] <> nil) then
   begin
      FDCn.Params.Assign(TFDConnectionDefParams(lbBancos.Items.Objects[lbBancos.ItemIndex]));
      if TfrmFDGUIxFormsConnEdit.Execute(FDCn,FDCn.Name) then
      begin
         lbBancos.Items.ValueFromIndex[lbBancos.ItemIndex] := FDCn.Params.Database;
         lbBancos.Items.Objects[lbBancos.ItemIndex] := FDCn.Params;
         GravaArquivoIni(lbBancos.ItemIndex.ToString,FDCn.Params);
      end;
   end;
end;

function TfmBancosRegistrados.ObterBanco: TFDConnectionDefParams;
begin
   fmBancosRegistrados.ShowModal;
   if (lbBancos.ItemIndex > -1) and (lbBancos.Items.Objects[lbBancos.ItemIndex] <> nil) then
      Result := TFDConnectionDefParams(lbBancos.Items.Objects[lbBancos.ItemIndex])
   else
      Result := nil;
end;

procedure TfmBancosRegistrados.RegistrarBanco(Params: TFDConnectionDefParams);
begin
   lbBancos.AddItem(Params.Database,Params);
   if not Ini.SectionExists((lbBancos.Count-1).ToString) then
      GravaArquivoIni((lbBancos.Count-1).ToString,Params);
end;

function TfmBancosRegistrados.RegistrarObterBanco(Params: TFDConnectionDefParams): TFDConnectionDefParams;
begin
   RegistrarBanco(Params);
   Result := ObterBanco;
end;

end.
