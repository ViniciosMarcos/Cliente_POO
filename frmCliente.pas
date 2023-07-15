unit frmCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.Buttons, uCliente, System.JSON, REST.Types,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client, Vcl.Mask,
  Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TF_Cliente = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    PnlBottom: TPanel;
    BtnSalvar: TBitBtn;
    PnlCenter: TPanel;
    EditID: TLabeledEdit;
    EditNome: TLabeledEdit;
    EditEndereco: TLabeledEdit;
    EditBairro: TLabeledEdit;
    EditNumero: TLabeledEdit;
    EditMunicipio: TLabeledEdit;
    EditEstado: TLabeledEdit;
    EditCEP: TLabeledEdit;
    EditCPFCNPJ: TLabeledEdit;
    EditTelefone: TLabeledEdit;
    EditDataNasc: TMaskEdit;
    PnlTopo: TPanel;
    ImgCliente: TImage;
    LblCadastro: TLabel;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    procedure EditCEPExit(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Cliente: TF_Cliente;

implementation

{$R *.dfm}



procedure TF_Cliente.BtnSalvarClick(Sender: TObject);
var
  Cliente :TCliente;
begin
  Cliente := TCliente.Create;
  Try
    Cliente.Nome      := EditNome.Text;
    Cliente.Endereco  := EditEndereco.Text;
    Cliente.Bairro    := EditBairro.Text;
    Cliente.Numero    := StrToInt(EditNumero.Text);
    Cliente.Municipio := EditMunicipio.Text;
    Cliente.Cep       := StrToInt(EditCEP.Text);
    Cliente.Estado    := EditEstado.Text;
    Cliente.CPFCNPJ   := StrToInt(EditCPFCNPJ.Text);
    Cliente.Telefone  := EditTelefone.Text;
    Cliente.DataNasc  := StrToDate(EditDataNasc.Text);

    Cliente.AdicionarCliente(Cliente);
  Except
    ShowMessage('N�o foi poss�vel inserir o novo cliente.');
  End;
end;

procedure TF_Cliente.EditCEPExit(Sender: TObject);
var
  Json: TJSONObject;
begin
  //Utilizacao da API ViaCEP
  RESTRequest1.Resource := Format('ws/%s/json/', [EditCEP.Text]);
  try
    RESTRequest1.Execute;
    Json := TJSONObject.ParseJSONValue(RESTResponse1.Content) as TJSONObject;
    EditMunicipio.Text := Json.GetValue('localidade').Value;
    EditEstado.Text    := Json.GetValue('uf').Value;
  finally

  end;
end;

end.
