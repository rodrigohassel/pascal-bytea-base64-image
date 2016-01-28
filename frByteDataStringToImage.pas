unit frByteDataStringToImage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFImageConvert = class(TForm)
    grpBinaryStringData: TGroupBox;
    mmoBinaryDataString: TMemo;
    grpImage: TGroupBox;
    imgImage: TImage;
    btnGerar: TButton;
    procedure btnGerarClick(Sender: TObject);
  private
    { Private declarations }
    function Base64FromBitmap(Bitmap: TBitmap): string;
    function BitmapFromBase64(const base64: string): TBitmap;
  public
    { Public declarations }
  end;

var
  FImageConvert: TFImageConvert;

implementation

uses
  EncdDecd;

{$R *.dfm}

{ TFImageConvert }

function TFImageConvert.Base64FromBitmap(Bitmap: TBitmap): string;
var
  Input: TMemoryStream;
  Output: TStringStream;
begin
  Input := TMemoryStream.Create;
  try
    Bitmap.SaveToStream(Input);
    Input.Position := 0;

    Output := TStringStream.Create('');
    try
      EncdDecd.EncodeStream(Input, Output);
      Result := Output.DataString;
    finally
      Output.Free;
    end;
  finally
    Input.Free;
  end;
end;

function TFImageConvert.BitmapFromBase64(const base64: string): TBitmap;
var
  Input: TStringStream;
  Output: TMemoryStream;
begin
  Input := TStringStream.Create(base64);
  try
    Output := TMemoryStream.Create;
    try
      EncdDecd.DecodeStream(Input, Output);
      Output.Position := 0;
      Output.SaveToFile(ExtractFilePath(ParamStr(0))+'FILE.TIF');
      try
        Result.LoadFromStream(Output);
      except
        Result.Free;
        raise;
      end;
    finally
      Output.Free;
    end;
  finally
    Input.Free;
  end;
end;

procedure TFImageConvert.btnGerarClick(Sender: TObject);
begin
  BitmapFromBase64(mmoBinaryDataString.Lines.Text);
end;

end.
