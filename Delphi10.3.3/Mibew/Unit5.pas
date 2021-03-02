unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, StdCtrls, Vcl.ExtCtrls, IdHTTP, IdMultipartFormData,IdSSL, IdSSLOpenSSL;
type
 TOperators1 = array of record
  id:integer;
  name:string;
  status:string;
  jpgname:string;
  domain:WideString;
 end;
type
  TForm5 = class(TForm)
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure SetOpsWindow(Operators1: TOperators1; userid:integer);
    procedure CursorOpWindow(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure CursorOutOpWindow(Sender: TObject);
    procedure ClickOpWindow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;
  UserID1:integer;

implementation

{$R *.dfm}
uses Unit4;
//uses Unit4;
procedure TForm5.CursorOpWindow(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if Sender is TPanel then (Sender as TPanel).Color := $00EEEEEE
  else
  if Sender is TLabel then ((Sender as TLabel).Parent as TPanel).Color := $00EEEEEE
  else
  if Sender is TImage then ((Sender as TImage).Parent as TPanel).Color := $00EEEEEE;
end;
procedure TForm5.CursorOutOpWindow(Sender: TObject);
begin
  if Sender is TPanel then (Sender as TPanel).Color := clWhite
  else
  if Sender is TLabel then ((Sender as TLabel).Parent as TPanel).Color := clWhite
  else
  if Sender is TImage then ((Sender as TImage).Parent as TPanel).Color := clWhite;
end;
procedure TForm5.ClickOpWindow(Sender: TObject);
var
opid,i,j:integer;
 HTTP: TIdHTTP;
 data: TIdMultiPartFormDataStream;
 Buffer:String;
 SSL:TIdSSLIOHandlerSocketOpenSSL;
begin
  if Sender is TPanel then opid := (Sender as TPanel).Tag
  else
  if Sender is TLabel then opid := ((Sender as TLabel).Parent as TPanel).Tag
  else
  if Sender is TImage then opid := ((Sender as TImage).Parent as TPanel).Tag;
//Form4.TabbedNotebook1.PageIndex := 4;
Form4.PageControl1.ActivePage := Form4.TabSheet4;
for i := 0 to Form4.ScrollBox1.ComponentCount -1 do
if (Form4.ScrollBox1.Components[i] as TPanel).Tag = UserID1 then j:=i;

//Form4.TabbedNotebook1.PageIndex := 2;
Form4.PageControl1.ActivePage := Form4.TabSheet3;
Dialogs.curuser := 0;

Form4.DeleteDialogUser(Form4.GetDialogUserId(UserID1));
(Form4.ScrollBox1.Components[j] as TPanel).Destroy;

  data := TIdMultiPartFormDataStream.Create;
  data.AddFormField('csrf_token', Cookie);
  data.AddFormField('userid', IntToStr(UserID1));
  data.AddFormField('opid', IntToStr(opid));

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
  HTTP.Request.CustomHeaders.text := 'Cookie: MibewSessionID='+MibewSessionID+'; ';
  try
    Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/user/redirect',data);
  except
    //ShowMessage('Отсутствует связь с сервером' + #10#13);
    Exit;
  end;
  HTTP.Destroy;
  SSL.Destroy;

Form5.Hide;
end;
procedure TForm5.SetOpsWindow(Operators1: TOperators1; userid:integer);
var
panel : TPanel;
labelName : TLabel;
labelStatus : TLabel;
labelDomain : TLabel;
img : TImage;
i : integer;
begin
 UserID1 := userid;
 ScrollBox1.DestroyComponents;
 for i := 0 to length(Operators1)-1 do
 if Operators1[i].status = 'В сети' then
 begin

    panel :=TPanel.Create(nil);
    panel.Parent := ScrollBox1;
    panel.Align := alNone;
    panel.Top := Trunc(ScrollBox1.ComponentCount / Trunc(ScrollBox1.ClientWidth / 130)) * 50 + 10;
    panel.Left := 0;
    panel.Tag := Operators1[i].id;
 //   panel.OnClick := Panel14Click;
    panel.ParentBackground := false;
    panel.Color := clWhite;
    panel.ShowCaption := false;
    panel.Width := 156; panel.BorderStyle := bsNone; panel.BevelInner := bvNone;
    panel.Height := 32; panel.BevelKind := bkNone; panel.BevelOuter := bvNone;
    panel.OnMouseMove := CursorOpWindow;
    panel.OnMouseLeave := CursorOutOpWindow;
    panel.OnClick := ClickOpWindow;

    labelName :=TLabel.Create(nil);
    labelName.Parent := panel;
    labelName.Caption := Operators1[i].name;
    labelName.Align := alNone;
    labelName.Left := 48;
    labelName.Top := 3; labelName.Font.Color := $00675551;
    labelName.Font.Name := 'Arial'; labelName.Font.Height := -12;
    labelName.OnMouseMove := CursorOpWindow;
    labelName.OnMouseLeave := CursorOutOpWindow;
    labelName.OnClick := ClickOpWindow;

    labelStatus :=TLabel.Create(nil);
    labelStatus.Parent := panel; //labelName.OnClick := Panel14Click;
    labelStatus.Caption := Operators1[i].status;labelStatus.Left := 48;labelStatus.Top := 16;
    if Operators1[i].status = 'В сети' then
     labelStatus.Font.Color := $0065BA34
     else labelStatus.Font.Color := $002168EB;
    labelStatus.Font.Name := 'Arial'; labelStatus.Font.Height := -12;labelStatus.Font.Style := [fsBold];
    labelStatus.OnMouseMove := CursorOpWindow;
    labelStatus.OnMouseLeave := CursorOutOpWindow;
    labelStatus.OnClick := ClickOpWindow;

    labelDomain := TLabel.Create(nil);
    labelDomain.Parent := panel;
    labelDomain.Caption := Operators1[i].domain;
    labelDomain.Visible := false;

    panel.InsertComponent(labelDomain);

    img :=TImage.Create(nil);
    img.Parent := panel;
    img.Align := alNone;
    img.Left := 10;img.Top := 0;img.Width := 32;img.Height := 32;
    img.OnMouseMove := CursorOpWindow;
    img.OnMouseLeave := CursorOutOpWindow;
    img.OnClick := ClickOpWindow;

    if Operators1[i].jpgname<>'' then Form4.DownloadJPG(Operators1[i].jpgname,img);

    ScrollBox1.InsertComponent(panel);
    ScrollBox1.Update;
    ScrollBox1.Invalidate;
 end;

end;

procedure TForm5.FormCreate(Sender: TObject);
begin
 Left:=(Screen.Width-Width)  div 2;
 Top:=(Screen.Height-Height) div 2;
// Form5.Hide();

end;

procedure TForm5.FormDeactivate(Sender: TObject);
begin
Form5.Hide;
end;

end.
