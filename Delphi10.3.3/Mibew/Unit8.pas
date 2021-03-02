unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls,Vcl.Menus, Vcl.Dialogs, IdHTTP, Forms,IdMultipartFormData, IdSSL, IdSSLOpenSSL,System.JSON, Rest.JSON,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, ShellAPI,Registry,StrUtils;

type
  TForm8 = class(TForm)
    Panel1: TPanel;
    Image2: TImage;
    Image1: TImage;
    CheckBox1: TCheckBox;
    Edit2: TEdit;
    Edit1: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1Click(Sender: TObject);
    procedure menu1OnDrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

uses Unit4;

procedure TForm8.FormActivate(Sender: TObject);
begin
Form8.CheckBox1.SetFocus;
end;

procedure TForm8.FormClose(Sender: TObject; var Action: TCloseAction);
var
 HTTP: TIdHTTP;
 data: TIdMultiPartFormDataStream;
 SSL:TIdSSLIOHandlerSocketOpenSSL;
 Buffer: String;
begin
 {/data := TIdMultiPartFormDataStream.Create;
  SSL:=TIdSSLIOHandlerSocketOpenSSL.Create(Application);
  SSL.ReadTimeOut:=10000;
  ///sslvSSLv2, sslvSSLv23, sslvSSLv3, sslvTLSv1,sslvTLSv1.sslvTLSv1_1,sslvTLSv1_2
  SSL.SSLOptions.Method:=sslvSSLv23;
  SSL.SSLOptions.Mode:=sslmUnassigned;
  HTTP := TIdHTTP.Create;
  HTTP.ReadTimeout:=10000;
  HTTP.ConnectTimeout:=10000;
  HTTP.IOHandler:=SSL;
  HTTP.AllowCookies:=true;
  data.Clear;
  HTTP.Request.CustomHeaders.text := 'Cookie: MibewSessionID='+MibewSessionID+'; ';
  try
    Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/logout',data);
  except
    ShowMessage('Отсутствует связь с сервером2' + #10#13 + Buffer);
    Exit;
  end;  }
  MustExit:=true;
  Shell_NotifyIcon(NIM_DELETE, @Form4.TrayIconData);
  Form4.Close;
  TerminateProcess(OpenProcess(PROCESS_TERMINATE,False,GetCurrentProcessId),0);
end;
procedure TForm8.menu1OnDrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
var
  mnu: TMenuitem;
begin
  mnu := Sender As TMenuitem;
  aCanvas.font.name := 'Arial';
  aCanvas.font.Style := [fsBold];
  aCanvas.font.Size := 10;
  If selected then begin
    aCanvas.font.color := $00DDA84E;
    aCanvas.brush.color := $00EDEDED;
  end
  else begin
    aCanvas.font.color := $00DDA84E;
    aCanvas.brush.color := clWhite;
  end;
  acanvas.brush.style := bsSolid;
  //arect.Height := 30;
  aCanvas.fillrect( aRect );
  acanvas.textrect( aRect, arect.left+10, arect.top+2, mnu.caption );
end;
function LoadCookies(s: string):string;//TStringList;
var
  i, y, z: Integer;
  new, temp: TStringList;
  OldP, NewP: string;
  CookieList : TStringList;
begin
  new := TStringList.Create;
  temp := TStringList.Create;
  while Pos('Set-Cookie', s) <> 0 do
  begin
    y := Pos('Set-Cookie', s);
    i := PosEx(': ', s, y) + 2;
    new.Add(Copy(s, i, PosEx(';', s, i) - i));
    Delete(s, y, 10);
  end;
  i := Pos('=', new.Strings[0]);
  NewP := Copy(new.Strings[0], i+1, Length(new.Strings[0]));

  //Result := new.Strings[0];
  Result := NewP;
end;
procedure TForm8.Image1Click(Sender: TObject);
var
Buffer: String;
 HTTP: TIdHTTP;
 data: TIdMultiPartFormDataStream;
 S,s1:String;
 SSL:TIdSSLIOHandlerSocketOpenSSL;
// ini: TIniFile;
 ini: TRegIniFile;
 needcookieToIni: bool;
 Sites: TSitesArray;
 i:integer;
 Item : TMenuItem;
 JSonValue: TJSonValue;
begin
if (Length(Edit1.Text)<2) OR (Length(Edit2.Text)<2) then Exit;

   cookie := '0';
  data := TIdMultiPartFormDataStream.Create;

  //Showmessage(cookie);
  //data.AddFormField('cookies', '0');

  SSL:=TIdSSLIOHandlerSocketOpenSSL.Create(Application);
  SSL.ReadTimeOut:=10000;
  ///sslvSSLv2, sslvSSLv23, sslvSSLv3, sslvTLSv1,sslvTLSv1.sslvTLSv1_1,sslvTLSv1_2
  SSL.SSLOptions.Method:=sslvSSLv23;
  SSL.SSLOptions.Mode:=sslmUnassigned;
  HTTP := TIdHTTP.Create;
  HTTP.ReadTimeout:=10000;
  HTTP.ConnectTimeout:=10000;
  HTTP.IOHandler:=SSL;
  HTTP.AllowCookies:=true;

//  try
//    Buffer := HTTP.Get('https://test3.console.vipsite.kz/api-chat/get-csrf-token');
//  except
//    ShowMessage('Отсутствует связь с сервером1' + #10#13);
//    Exit;
//  end;
//  Cookie := getJSONItem(Buffer,'csrf_token');
//  data.AddFormField('csrf_token', Cookie);
//
//
//  try
//    Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/logout',data);
//  except
//    ShowMessage('Отсутствует связь с сервером2' + #10#13 + Buffer);
//    Exit;
//  end;
//ShowMessage(HTTP.Response.RawHeaders.GetText);

  try
    Buffer := HTTP.Get('https://test3.console.vipsite.kz/api-chat/get-csrf-token');
  except
    ShowMessage('Отсутствует связь с сервером3' + #10#13);
    Exit;
  end;
  MibewSessionID := LoadCookies(HTTP.Response.RawHeaders.GetText);
  data.Clear;
  data.AddFormField('login', Edit1.Text);
  data.AddFormField('password', Edit2.Text);
  Cookie := getJSONItem(Buffer,'csrf_token');
  data.AddFormField('csrf_token', Cookie);

  Buffer := '';
  try
    Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/login',data);
  except
    ShowMessage('Отсутствует связь с сервером4' + #10#13);
    Exit;
  end;

//  data.Clear;
//  HTTP.Request.CustomHeaders.text := 'Cookie: MibewSessionID='+MibewSessionID+'; ';
//  try
//    Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/logout',data);
//  except
//    ShowMessage('Отсутствует связь с сервером2' + #10#13 + Buffer);
//    Exit;
//  end;
//ShowMessage(Buffer);
//ShowMessage(LoadCookies(HTTP.Response.RawHeaders.GetText).Text);
//ShowMessage(HTTP.Response.RawHeaders.GetText);
//ShowMessage(Buffer);



  //Buffer := HTTP.Get('https://stackoverflow.com/questions/27058054/delphi-how-to-parse-specified-values-from-http-get');
 // Cookie := getJSONItem(Buffer,'cookies');
     JsonValue := TJSonObject.ParseJSONValue(Buffer);
  if JsonValue.FindValue('code') = nil then
begin
  if Buffer <>'' then
  begin
  //ShowMessage(Buffer);
    OperatorID := getJSONItem(Buffer,'id');
    Form4.DownloadJPG(getJSONItem(Buffer,'jpgname'),Form4.Image8);
    Form4.Label20.Caption := getJSONItem(Buffer,'name');

    Form4.OpsSites.Items.Clear;
    Form4.UsersSites.Items.Clear;
    Form4.ScrollBox3.DestroyComponents;
    Sites := getSites(Buffer);
    for i := 0 to Length(Sites)-1 do
    Form4.InsertSiteToScrollBox(StrToInt(Sites[i].id) ,Sites[i].site );

    Item := TMenuItem.Create(Form4.OpsSites);
    Item.Caption := '-';
    Item.OnClick := Form4.HandleOpsSites;
    Item.OnDrawItem := menu1OnDrawItem;
    Form4.OpsSites.OwnerDraw := true;
    Form4.OpsSites.Items.Add(Item);
    Item := TMenuItem.Create(Form4.OpsSites);
    Item.Caption := 'Всех сайтах';
    Item.OnClick := Form4.HandleOpsSites;
    Item.OnDrawItem := menu1OnDrawItem;
    Form4.OpsSites.OwnerDraw := true;
    Form4.OpsSites.Items.Add(Item);

    Item := TMenuItem.Create(Form4.UsersSites);
    Item.Caption := '-';
    Item.OnClick := Form4.N5Click;
    Item.OnDrawItem := menu1OnDrawItem;
    Form4.UsersSites.OwnerDraw := true;
    Form4.UsersSites.Items.Add(Item);
    Item := TMenuItem.Create(Form4.UsersSites);
    Item.Caption := 'Все сайты';
    Item.OnClick := Form4.N5Click;
    Item.OnDrawItem := menu1OnDrawItem;
    Form4.UsersSites.OwnerDraw := true;
    Form4.UsersSites.Items.Add(Item);

//    ini := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
    ini := TRegIniFile.Create('Software\Nachalosaita');

    try
    if CheckBox1.Checked then ini.WriteString('cookie', 'logedin', 'true')
       else ini.WriteString('cookie', 'logedin', 'false');
    ini.WriteString('cookie', 'login', Edit1.Text);
    ini.WriteString('cookie', 'password', Edit2.Text);
    finally
     ini.Free;
    end;
    Form8.Hide;
    Form4.Show;
    NeedExit := false;
    Dec(QueueUpdates);
    NeedExit2 := false ;
    SetTimer(Form4.Handle,QueueUpdates,1000,@Updates);
  end
  else ShowMessage('Пользователь не найден!');
end;
  HTTP.Destroy;
  SSL.Destroy;
end;

end.
