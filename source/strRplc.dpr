program strRplc;

uses
  Vcl.Forms,
  v.main in 'v.main.pas' {vMain},
  svc.option in 'svc.option.pas' {svcOption: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TsvcOption, svcOption);
  Application.CreateForm(TvMain, vMain);
  Application.Run;
end.
