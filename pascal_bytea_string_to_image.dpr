program pascal_bytea_string_to_image;

uses
  Forms,
  frByteDataStringToImage in 'frByteDataStringToImage.pas' {FImageConvert};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFImageConvert, FImageConvert);
  Application.Run;
end.
