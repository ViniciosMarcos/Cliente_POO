program Cliente_POO;

uses
  Vcl.Forms,
  frmCliente in 'frmCliente.pas' {F_Cliente},
  uCliente in 'uCliente.pas',
  DM_BD in 'DM_BD.pas' {F_DMFD: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TF_Cliente, F_Cliente);
  Application.CreateForm(TF_DMFD, F_DMFD);
  Application.Run;
end.
