unit svc.option;

interface

uses
  mRegOption,

  System.SysUtils, System.Classes, RzCommon;

type
  TDataModule = TRegOption;
  TsvcOption = class(TDataModule)
    Reg: TRzRegIniFile;
    procedure DataModuleCreate(Sender: TObject);
  private
  protected
    function GetRegIniFile(var APath: String): TRzRegIniFile; override;
  public
    property LastRplcTxt: String index $0000 read GetString write SetString;
  end;

var
  svcOption: TsvcOption;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  System.Math
  ;

{ TsvcOption }

procedure TsvcOption.DataModuleCreate(Sender: TObject);
begin
  Add('Server', [
    ['Addr', '127.0.0.1'],
    ['Port', '8080']
  ]);
end;

function TsvcOption.GetRegIniFile(var APath: String): TRzRegIniFile;
begin
  Result := Reg;
  APath := 'SDBIOSENSOR\flineqc';
end;

end.

