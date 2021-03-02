unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls,Vcl.Menus, Vcl.Dialogs, IdHTTP, Forms,IdMultipartFormData, IdSSL, IdSSLOpenSSL,System.JSON, Rest.JSON,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, ShellAPI,Registry;

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
begin
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
begin
   cookie := '0';
  data := TIdMultiPartFormDataStream.Create;
  //Showmessage(cookie);
  data.AddFormField('cookies', '0');
  data.AddFormField('login', Edit1.Text);
  data.AddFormField('password', Edit2.Text);

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
  try
    Buffer := HTTP.Post('https://nachalosaita.itgroup.kz/sitesusers/loginoperator.php',data);
  except
    ShowMessage('Отсутствует связь с сервером' + #10#13);
    Exit;
  end;

  //Buffer := HTTP.Get('https://stackoverflow.com/questions/27058054/delphi-how-to-parse-specified-values-from-http-get');
  Cookie := getJSONItem(Buffer,'cookies');
  if Cookie <>'0' then
  begin
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
    ini.WriteString('cookie', 'cookie', cookie);
    finally
     ini.Free;
    end;
    Form8.Hide;
    Form4.Show;
    NeedExit := false;
    Dec(QueueUpdates);
    SetTimer(Form4.Handle,QueueUpdates,1000,@Updates);
  end
  else ShowMessage('Пользователь не найден!');

  HTTP.Destroy;
  SSL.Destroy;
end;

end.
