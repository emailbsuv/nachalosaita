unit Unit4;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellAPI, StdCtrls, Menus, Vcl.ExtCtrls, IdHTTP, IdMultipartFormData, System.JSON, Rest.JSON,
  IdSSL, IdSSLOpenSSL,System.Generics.Collections,MSHTML,JPEG,
  System.Net.URLClient, System.Net.HttpClient, Soap.SOAPHTTPTrans, Vcl.OleCtrls,
  SHDocVw, Vcl.Imaging.pngimage, Vcl.Tabs, Vcl.ComCtrls, Vcl.TabNotBk,Unit5,Unit6;

const WM_ICONTRAY = WM_USER+1;

type
  TForm4 = class(TForm)
    PopupMenu1: TPopupMenu;
    ShowForm1: TMenuItem;
    HideForm1: TMenuItem;
    Exit1: TMenuItem;
    Panel1: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    ScrollBox1: TScrollBox;
    Panel3: TPanel;
    Button3: TButton;
    Button1: TButton;
    Panel4: TPanel;
    TabbedNotebook1: TTabbedNotebook;
    Panel7: TPanel;
    Panel8: TPanel;
    Image2: TImage;
    Memo1: TMemo;
    Image3: TImage;
    WebBrowser1: TWebBrowser;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Panel11: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Memo2: TMemo;
    Button2: TButton;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Panel12: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Panel13: TPanel;
    Label18: TLabel;
    Label19: TLabel;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Label20: TLabel;
    Label21: TLabel;
    Button4: TButton;
    Label22: TLabel;
    Label23: TLabel;
    PopupMenu2: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    ScrollBox2: TScrollBox;
    Panel15: TPanel;
    Label27: TLabel;
    Label28: TLabel;
    OpsSites: TPopupMenu;
    N3: TMenuItem;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel14: TPanel;
    Label24: TLabel;
    ScrollBox3: TScrollBox;
    Panel18: TPanel;
    Panel19: TPanel;
    Panel20: TPanel;
    Label25: TLabel;
    Label26: TLabel;
    ScrollBox4: TScrollBox;
    procedure TrayMessage(var Msg: TMessage); message WM_ICONTRAY;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ShowForm4Click(Sender: TObject);
    procedure HideForm4Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure CallFoo(S: string; I: Integer;T: string);
    procedure Button3Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Panel14Click(Sender: TObject);
    procedure Label24Click(Sender: TObject);
    procedure InsertUserToDialogs(id: Integer;newmsgcnt: string;name: string; phone: string;
      email: string;comment: string;ip: string;urlfrom: string;urlto: string;view: string;
      onsitetime: string;pageviews: string;visits: string;optypemsg: string;innerHTML: WideString);
    function GetDialogUserId (i:integer) : integer;
    procedure DeleteDialogUser( const pos:integer);
    procedure FormShow(Sender: TObject);
    procedure Label18Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure DownloadJPG(url:string;im:TImage);
    procedure InsertOpToScrollBox(id:integer;name:string;status:string;jpgname:string;domain:WideString);
    procedure ScrollBox2Resize(Sender: TObject);
    procedure InsertSiteToScrollBox(id:integer;domain:string);
    procedure LabelSiteClose(Sender: TObject);
    procedure Label28Click(Sender: TObject);
    procedure HandleOpsSites(Sender: TObject);
    procedure InsertUserToScrollBox(id:integer;name:string;phone:string;email:string;comment:WideString;ip:string;urlfrom:string;view:string;onsitetime:string;pageviews:string;visits:string;dialogscnt:string;opname:string;opjpg:string);

//    procedure CreateParams (var Params: TCreateParams); override;
  private
   TrayIconData: TNotifyIconData;
  end;
type
 TUserDialog = array of record
  id : integer;
  newmsgcnt     : string[5];
  name     : string[255];
  phone     : string[255];
  email     : string[255];
  comment     : WideString;
  ip     : string[35];
  urlfrom     : string[255];
  urlto     : string[255];
  view     : string[255];
  onsitetime     : string[15];
  pageviews     : string[15];
  visits     : string[15];
  optypemsg     : WideString;
  innerHTML   : WideString;
 end;
type
 TUrlCash = array of record
  jpg : TMemoryStream;
  jpgName : string[30];
 end;
type
 TOperators = array of record
  id:integer;
  name:string;
  status:string;
  jpgname:string;
  domain:WideString;
 end;
type TUsersDialog = record
 users : TUserDialog;
 userscount,curuser : integer;
 end;

var
  Form4: TForm4;
  MustExit:boolean;
  label1: hwnd;
  btn1: hwnd;
  WinClass : TWndClass;
  hInst : HWND;
  Handle,Handle1 : THandle;
  hFont : HWND;
  rect: trect;
  left,nleft,ntop,top,w,h: integer;
  Dialogs : TUsersDialog;
  Queue: Integer = 0;
  UrlCash : TUrlCash;
  Operators : TOperators;


implementation
uses Types;
{$R *.dfm}

procedure TForm4.HandleOpsSites(Sender: TObject);
var
panel : TPanel;
labelName : TLabel;
labelStatus : TLabel;
labelDomain : TLabel;
img : TImage;
i : integer;
begin
  ScrollBox2.DestroyComponents;
  Label28.Caption := TMenuItem(Sender).Caption;
  for i := 0 to length(Operators)-1 do
    begin
      if (Pos(WideString(TMenuItem(Sender).Caption),Operators[i].domain)>0) or (TMenuItem(Sender).Caption = 'Всех сайтах') then
      begin

        panel :=TPanel.Create(nil);
        panel.Parent := ScrollBox2;
        panel.Align := alNone;
        panel.Top := Trunc(ScrollBox2.ComponentCount / Trunc(ScrollBox2.ClientWidth / 130)) * 50 + 10;
        panel.Left := (ScrollBox2.ComponentCount - (Trunc(ScrollBox2.ComponentCount / Trunc(ScrollBox2.ClientWidth / 130))*Trunc(ScrollBox2.ClientWidth / 130)))* 130 + 10;
        panel.Tag := Operators[i].id;
     //   panel.OnClick := Panel14Click;
        panel.ParentBackground := false;
        panel.Color := clSilver;
        panel.ShowCaption := false;
        panel.Width := 120;
        panel.Height := 40;

        labelName :=TLabel.Create(nil);
        labelName.Parent := panel;
        labelName.Caption := Operators[i].name;
        labelName.Align := alNone;
        labelName.Left := 38;
        labelName.Top := 6; labelName.Font.Color := $00675551;
        labelName.Font.Name := 'Arial'; labelName.Font.Height := -12;
    //    labelName.OnClick := Label24Click;

        labelStatus :=TLabel.Create(nil);
        labelStatus.Parent := panel; //labelName.OnClick := Panel14Click;
        labelStatus.Caption := Operators[i].status;labelStatus.Left := 38;labelStatus.Top := 19;
        if Operators[i].status = 'В сети' then
         labelStatus.Font.Color := $0065BA34
         else labelStatus.Font.Color := $002168EB;
        labelStatus.Font.Name := 'Arial'; labelStatus.Font.Height := -12;labelStatus.Font.Style := [fsBold];

        labelDomain := TLabel.Create(nil);
        labelDomain.Parent := panel;
        labelDomain.Caption := Operators[i].domain;
        labelDomain.Visible := false;

        panel.InsertComponent(labelDomain);

        img :=TImage.Create(nil);
        img.Parent := panel;
        img.Align := alNone;
        img.Left := 0;img.Top := 0;img.Width := 32;img.Height := 32;

        DownloadJPG(Operators[i].jpgname,img);

        ScrollBox2.InsertComponent(panel);
        ScrollBox2.Update;
        ScrollBox2.Invalidate;
      end;
    end;

  //MessageDlg(TMenuItem(Sender).Caption,mtCustom,[mbYes,mbAll,mbCancel], 0);
end;
procedure TForm4.InsertUserToScrollBox(id:integer;name:string;phone:string;email:string;comment:WideString;ip:string;urlfrom:string;view:string;onsitetime:string;pageviews:string;visits:string;dialogscnt:string;opname:string;opjpg:string);
begin

end;

procedure TForm4.LabelSiteClose(Sender: TObject);
var
  l : TLabel;
  i : integer;
begin
  l := Sender as TLabel;
 //(l.Parent as TPanel).Tag;
  i := 0;
  while i < OpsSites.Items.Count do
  begin
    if OpsSites.Items[i].Caption = ((l.Parent as TPanel).Components[0] as TLabel).Caption then
      OpsSites.Items.Delete(i)
    else
      Inc(i);
  end;

  l.Parent.Destroy;
  for i := 0 to ScrollBox3.ComponentCount -1 do
    begin
      (ScrollBox3.Components[i] as TPanel).Top := i * 30 +10;
    end;

end;
procedure TForm4.InsertSiteToScrollBox(id:integer;domain:string);
var
panel : TPanel;
labelDomain,labelClose : TLabel;
Item: TMenuItem;
begin

    panel :=TPanel.Create(nil);
    panel.Parent := ScrollBox3;
    panel.Align := alNone;
    panel.Top := ScrollBox3.ComponentCount  * 30 + 10;
    panel.Left := 10;//(ScrollBox3.ComponentCount - (Trunc(ScrollBox3.ComponentCount / Trunc(ScrollBox3.ClientWidth / 150))*Trunc(ScrollBox3.ClientWidth / 150)))* 150 + 10;
    panel.Tag := id;
 //   panel.OnClick := Panel14Click;
    panel.ParentBackground := false;
    panel.Color := clSilver;
    panel.ShowCaption := false;
    panel.Height := 25;

    labelDomain :=TLabel.Create(nil);
    labelDomain.Parent := panel; labelDomain.AutoSize :=true; //labelName.OnClick := Panel14Click;
    labelDomain.Caption := domain;labelDomain.Left := 4;labelDomain.Top := 4;//labelDomain.Width := 120;
    labelDomain.Font.Color := $006F5F5B; labelDomain.Font.Name := 'Arial'; labelDomain.Font.Height := -14;labelDomain.Font.Style := [fsBold];

    Item := TMenuItem.Create(OpsSites);
    Item.Caption := domain;
    Item.OnClick := HandleOpsSites;
    OpsSites.Items.Add(Item);
    panel.Width := labelDomain.Width+40;

    labelClose :=TLabel.Create(nil);
    labelClose.Parent := panel;
    labelClose.Caption := 'x';
    labelClose.Font.Color := $00FF0000;
    labelClose.Align := alRight;
    labelClose.Width := 15;
    labelClose.Layout := tlCenter;
    labelClose.OnClick := LabelSiteClose;

    panel.InsertComponent(labelDomain);

    ScrollBox3.InsertComponent(panel);
    ScrollBox3.Update;
    ScrollBox3.Invalidate;

end;
procedure TForm4.InsertOpToScrollBox(id:integer;name:string;status:string;jpgname:string;domain:WideString);
var
panel : TPanel;
labelName : TLabel;
labelStatus : TLabel;
labelDomain : TLabel;
img : TImage;
i : integer;
begin
    i := length(Operators);
    SetLength(Operators, i+1);
    Operators[i].id := id;
    Operators[i].name := name;
    Operators[i].status := status;
    Operators[i].jpgname := jpgname;
    Operators[i].domain := domain;

    panel :=TPanel.Create(nil);
    panel.Parent := ScrollBox2;
    panel.Align := alNone;
    panel.Top := Trunc(ScrollBox2.ComponentCount / Trunc(ScrollBox2.ClientWidth / 130)) * 50 + 10;
    panel.Left := (ScrollBox2.ComponentCount - (Trunc(ScrollBox2.ComponentCount / Trunc(ScrollBox2.ClientWidth / 130))*Trunc(ScrollBox2.ClientWidth / 130)))* 130 + 10;
    panel.Tag := id;
 //   panel.OnClick := Panel14Click;
    panel.ParentBackground := false;
    panel.Color := clSilver;
    panel.ShowCaption := false;
    panel.Width := 120;
    panel.Height := 40;

    labelName :=TLabel.Create(nil);
    labelName.Parent := panel;
    labelName.Caption := name;
    labelName.Align := alNone;
    labelName.Left := 38;
    labelName.Top := 6; labelName.Font.Color := $00675551;
    labelName.Font.Name := 'Arial'; labelName.Font.Height := -12;
//    labelName.OnClick := Label24Click;

    labelStatus :=TLabel.Create(nil);
    labelStatus.Parent := panel; //labelName.OnClick := Panel14Click;
    labelStatus.Caption := status;labelStatus.Left := 38;labelStatus.Top := 19;
    if status = 'В сети' then
     labelStatus.Font.Color := $0065BA34
     else labelStatus.Font.Color := $002168EB;
    labelStatus.Font.Name := 'Arial'; labelStatus.Font.Height := -12;labelStatus.Font.Style := [fsBold];

    labelDomain := TLabel.Create(nil);
    labelDomain.Parent := panel;
    labelDomain.Caption := domain;
    labelDomain.Visible := false;

    panel.InsertComponent(labelDomain);

    img :=TImage.Create(nil);
    img.Parent := panel;
    img.Align := alNone;
    img.Left := 0;img.Top := 0;img.Width := 32;img.Height := 32;

    DownloadJPG(jpgname,img);

    ScrollBox2.InsertComponent(panel);
    ScrollBox2.Update;
    ScrollBox2.Invalidate;

end;
procedure TForm4.DownloadJPG(url:string;im:TImage);
var
str :TMemoryStream;
jpegimg: TJPEGImage;
idhttp1:TIdHTTP;
SSL:TIdSSLIOHandlerSocketOpenSSL;
i,j :integer;
begin
    i := -1;
    for j := 0 to length(UrlCash)-1 do
    begin
      if UrlCash[j].jpgName = url then i := j;
    end;
    if i = -1 then
    begin
      idhttp1 := TIdHTTP.Create(nil); idhttp1.ReadTimeout:=10000;
      SSL:=TIdSSLIOHandlerSocketOpenSSL.Create(Application);
      SSL.ReadTimeOut:=10000;
      ///sslvSSLv2, sslvSSLv23, sslvSSLv3, sslvTLSv1,sslvTLSv1.sslvTLSv1_1,sslvTLSv1_2
      SSL.SSLOptions.Method:=sslvSSLv23;
      SSL.SSLOptions.Mode:=sslmUnassigned;
      idhttp1.IOHandler:=SSL;
      str:=TMemoryStream.Create;
      try
      idhttp1.Get('http://nachalosaita.itgroup.kz/img/'+url,str);
      except
      //ShowMessage('Image was not found');
      Exit;
      end;
      jpegimg := TJPEGImage.Create;
      try
      str.Position := 0;
      jpegimg.LoadFromStream(str);
      im.Picture.Assign(jpegimg);
      SetLength(UrlCash, length(UrlCash)+1);
      UrlCash[length(UrlCash)-1].jpg := TMemoryStream.Create;
      (UrlCash[length(UrlCash)-1].jpg as TMemoryStream).Position := 0;
      im.Picture.SaveToStream((UrlCash[length(UrlCash)-1].jpg as TMemoryStream));
      UrlCash[length(UrlCash)-1].jpgname := url;
      finally
      SSL.Free;
      idhttp1.Free;
      str.Free;
      jpegimg.Free;
      end;
    end
    else
    begin
     (UrlCash[i].jpg as TMemoryStream).Position := 0;
     im.Picture.LoadFromStream((UrlCash[i].jpg as TMemoryStream));
    end;
end;
procedure TForm4.CallFoo(S: string; I: Integer;T: string);
var
  Doc: IHTMLDocument2;
  HTMLWindow: IHTMLWindow2;
  JSFn: string;
begin
  Doc := WebBrowser1.Document as IHTMLDocument2;
  if not Assigned(Doc) then
    Exit;
  HTMLWindow := Doc.parentWindow;
  if not Assigned(HTMLWindow) then
    Exit;

  try
    JSFn := Format('doupdate("%s",%d,"%s")', [S, I, T]);
    HTMLWindow.execScript(JSFn, 'JavaScript');
  except
    // handle exception in case JavaScript fails to run
  end;
end;
procedure Proc(hWnd: HWND; uMsg: UINT; idEvent: UINT_PTR; dwTime: DWORD); stdcall;
var
Item : TMenuItem;
begin
  Form4.InsertUserToDialogs(1,'7','Дмитрий','+380988988692','dima@mail.ru',
      'Добавить комментарий','192.168.100.101','www.google.com','nachalosaita.itgroup.kz','Главная страница',
      '1 час 2 мин.','12','3','Здравствуйте, чем я могу вам помочь?','<div class="style7" id="chatform"><div id="mainform" style="transform: translateY(0px);" height="100%"></div></div>');
  Form4.InsertUserToDialogs(2,'9','Денис','+380988988692','denis@mail.ru',
      'Добавить комментарий','192.168.100.101','www.google.com','nachalosaita.itgroup.kz','Новости',
      '1 час 2 мин.','12','3','Здравствуйте, чем я могу вам помочь?','<div class="style7" id="chatform"><div id="mainform" style="transform: translateY(0px);" height="100%"></div></div>');
  Form4.InsertUserToDialogs(3,'','Андрей','+380988988692','andrey@mail.ru',
      'Добавить комментарий','192.168.100.101','www.google.com','nachalosaita.itgroup.kz','Ноунтбук',
      '1 час 2 мин.','12','3','Здравствуйте, чем я могу вам помочь?','<div class="style7" id="chatform"><div id="mainform" style="transform: translateY(0px);" height="100%"></div></div>');
  Form4.InsertOpToScrollBox(1,'Андрей','В сети','alex.jpg','nachalosaita.itgroup.kz');
  Form4.InsertOpToScrollBox(2,'Андрей2','В сети','alex.jpg','nachalosaita.itgroup.kz2');
  Form4.InsertOpToScrollBox(3,'Андрей3','В сети','alex.jpg','nachalosaita.itgroup.kz3');
  Form4.InsertOpToScrollBox(4,'Андрей4','Отошёл','alex.jpg','nachalosaita.itgroup.kz4');
  Form4.InsertOpToScrollBox(5,'Андрей5','В сети','alex.jpg','nachalosaita.itgroup.kz5');
  Form4.InsertOpToScrollBox(6,'Андрей6','В сети','alex.jpg','nachalosaita.itgroup.kz6');
  Form4.InsertOpToScrollBox(7,'Андрей7','Отошёл','alex.jpg','nachalosaita.itgroup.kz7');
  Form4.InsertOpToScrollBox(8,'Андрей8','В сети','alex.jpg','nachalosaita.itgroup.kz8');

  Form4.InsertOpToScrollBox(9,'Андрей9','В сети','alex.jpg','nachalosaita.itgroup.kz');
  Form4.InsertOpToScrollBox(10,'Андрей10','В сети','alex.jpg','nachalosaita.itgroup.kz2, nachalosaita.itgroup.kz5');
  Form4.InsertOpToScrollBox(11,'Андрей11','В сети','alex.jpg','nachalosaita.itgroup.kz3');
  Form4.InsertOpToScrollBox(12,'Андрей12','Отошёл','alex.jpg','nachalosaita.itgroup.kz4');
  Form4.InsertOpToScrollBox(13,'Андрей13','В сети','alex.jpg','nachalosaita.itgroup.kz5');
  Form4.InsertOpToScrollBox(14,'Андрей14','В сети','alex.jpg','nachalosaita.itgroup.kz6');
  Form4.InsertOpToScrollBox(15,'Андрей15','В сети','alex.jpg','nachalosaita.itgroup.kz7');
  Form4.InsertOpToScrollBox(16,'Андрей16','В сети','alex.jpg','nachalosaita.itgroup.kz8');

  Form4.OpsSites.Items.Clear;
  Form4.InsertSiteToScrollBox(1,'nachalosaita.itgroup.kz');
  Form4.InsertSiteToScrollBox(2,'nachalosaita.itgroup.kz2');
  Form4.InsertSiteToScrollBox(3,'nachalosaita.itgroup.kz3');
  Form4.InsertSiteToScrollBox(4,'nachalosaita.itgroup.kz4');
  Form4.InsertSiteToScrollBox(5,'nachalosaita.itgroup.kz5');
  Form4.InsertSiteToScrollBox(6,'nachalosaita.itgroup.kz6');
  Form4.InsertSiteToScrollBox(7,'nachalosaita.itgroup.kz7');
  Form4.InsertSiteToScrollBox(8,'nachalosaita.itgroup.kz8');
  Item := TMenuItem.Create(Form4.OpsSites);
  Item.Caption := '-';
  Item.OnClick := Form4.HandleOpsSites;
  Form4.OpsSites.Items.Add(Item);
  Item := TMenuItem.Create(Form4.OpsSites);
  Item.Caption := 'Всех сайтах';
  Item.OnClick := Form4.HandleOpsSites;
  Form4.OpsSites.Items.Add(Item);

  Form4.InsertUserToScrollBox(1,'Иннокентий','Добавить телефон','innokentiy@mail.ru','Добавить комментарий','192.168.101.11','www.google.com','Главная страница','1 час 15 мин.','2','25','111','Алуа','alex.jpg');

    KillTimer(Application.Handle, idEvent);
  Form4.DownloadJPG('alex.jpg',Form4.Image8);
end;
procedure TForm4.FormCreate(Sender: TObject);
var
  form: TForm;
  Doc: Variant;
  b : TButton;
begin
 Application.Title := 'Началосайта';
 Left:=(Screen.Width-Width)  div 2;
 Top:=(Screen.Height-Height) div 2;
  b := TButton.Create(nil);
  b.Top := 0; b.Left :=0;
  application.InsertComponent(b);
  MustExit:=false;
  TrayIconData.cbSize:=SizeOf(TrayIconData);
  TrayIconData.Wnd:=Handle;
  TrayIconData.uID:=0;
  TrayIconData.uFlags:=NIF_MESSAGE + NIF_ICON + NIF_TIP;
  TrayIconData.uCallbackMessage:=WM_ICONTRAY;
  TrayIconData.hIcon:=Application.Icon.Handle;
  StrPCopy(TrayIconData.szTip,Application.Title);
  Shell_NotifyIcon(NIM_ADD, @TrayIconData);
  Form4.Show;

  if NOT Assigned(WebBrowser1.Document) then
    WebBrowser1.Navigate('about:blank');

  Doc := WebBrowser1.Document;
  Doc.Clear;
  Doc.Write('<html><meta charset="UTF-8"> <style> div.style7{horizontcal-align: right;height: 120px; width: 213px; left: 0px; position: relative; top: 0px; border: 0px;background:#FFFFFF;}div.style8{width: 343px; left: 0px; font-family:'+
  ' Arial; color: #FFFFFF; background'+
':#3DC76F; vertical-align: middle;padding-left: 10px;padding-right: 5px;padding-top: 5px;padding-bottom: 5px;border-left: 20px solid #FFFFFF;border-top: 20px solid #FFFFFF;font-size: 14px;position: relative;border-image: url("http://nachalosaita.itgroup.'+
'kz/img/l2.png") 40 / 40px 0px 0px 20px ; background-clip: padding-box;}div.style9{width: 343px; left: 230px; font-family: Arial; color: #000000; background:#EDEDED; vertical-align: middle;padding-left: 10px;padding-right: 5px;padding-top: 5px;padding-bot'+
'tom: 5px;border-right: 20px solid #FFFFFF;border-top: 20px solid #FFFFFF;font-size: 15px;position: relative;border-image: url("http://nachalosaita.itgroup.kz/img/l3.png") 40 / 40px 20px 0px 20px ; background-clip: padding-box;}</style> <script type="'+
'text/javascript"> function onWheel(e){e = e || window.event; var delta = e.deltaY || e.detail || e.wheelDelta; var info = document.getElementById("mainform"); var y = parseInt(getTranslateY(info))*-1; if((y <= (info.offsetHeight-opposite(delta)*15)) &'+
'& ((y+opposite(delta)*15) >= 0)) info.style.transform = "translateY("+(parseInt(getTranslateY(info))-opposite(delta)*15)+"px)"; e.preventDefault ? e.preventDefault() : (e.returnValue = false);}function getTranslateY(obj){var style = obj.style, transfo'+
'rm = style.transform || style.webkitTransform || style.mozTransform || style.msTransform, zT = transform.match(/translateY\((-?[0-9]+(px|em|%|ex|ch|rem|vh|vw|vmin|vmax|mm|cm|in|pt|pc))\)/); return zT ? zT[1] : "0";}function opposite(number){if (number'+
' < 0){return 1}else{return -1}}function doupdate(message,i,title){if(i==1){var newmsg = document.createElement("DIV"); newmsg.innerText = message;newmsg.title=title;newmsg.className ="style9"; document.getElementById("mainform").appendChild(newmsg);}el'+
'se{var'+
' newmsg = document'+
'.createElement("DIV"); newmsg.innerText = message;newmsg.title=title;newmsg.className ="style8"; document.getElementById("mainform").appendChild(newmsg); document.getElementById("mainform").style.transform = "translateY("+(document.getElementById("mainf'+
'orm").offsetHeight '+
'*-1 +100)+"px)";}}function l(){var elem = document.getElementById("chatform"); if (elem.addEventListener){if ("onwheel" in document){elem.addEventListener("wheel", onWheel);}else if ("onmousewheel" in document){elem.addEventListener("mousewheel", onWhee'+
'l);}else{elem.addEventListener("MozMousePixelScroll", onWheel);}}else{elem.attachEvent("onmousewheel", onWheel);}}(function(){if(document.readyState=="complete"){l();}else{if(window.attachEvent){window.attachEvent("onload",l);}else{addEventListener("lo'+
'ad",l,false);}}})(); </script> <body><div class="style7" id="chatform"><div id="mainform" style="transform: translateY(0px);" height="100%"></div></div></body></html> ');
  Doc.Close;
  Dialogs.userscount := 0;Dialogs.curuser := 0; SetLength(Dialogs.users, 0);
  Inc(Queue);
  SetTimer(Application.Handle,Queue,2000,@Proc);

end;

procedure TForm4.FormDestroy(Sender: TObject);
begin
  Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
end;

procedure TForm4.FormShow(Sender: TObject);
begin
 //ShowWindow(Handle1, SW_HIDE);
 Form4.Show;
end;

procedure TForm4.TrayMessage(var Msg: TMessage);
var p:TPoint;
begin
  case Msg.lParam of
    WM_LBUTTONDOWN: begin

                     Form4.Show;
                     Application.Restore;
                    end;
    WM_RBUTTONDOWN: begin
                     GetCursorPos(p);
                     PopUpMenu1.Popup(p.x,p.y);
                    end;
  end;
end;

// Popup "Form Show" menu item OnClick
procedure TForm4.ScrollBox2Resize(Sender: TObject);
var
 i : integer;
begin
  for i := 0 to ScrollBox2.ComponentCount -1 do
    begin
    (ScrollBox2.Components[i] as TPanel).Top := Trunc(i / Trunc(ScrollBox2.ClientWidth / 130)) * 50 + 10;
    (ScrollBox2.Components[i] as TPanel).Left := (i - (Trunc(i / Trunc(ScrollBox2.ClientWidth / 130))*Trunc(ScrollBox2.ClientWidth / 130)))* 130 + 10;
    end;


end;

procedure TForm4.ShowForm4Click(Sender: TObject);
begin
 Form4.Show;
end;

// Popup "Form Hide" menu item OnClick
procedure TForm4.HideForm4Click(Sender: TObject);
begin
 Form4.Hide;
end;

procedure TForm4.Image2Click(Sender: TObject);
var
  myDate : TDateTime;
  V : WideString;
  i: integer;
  formattedDateTime : string;
begin
    //CallFoo('Здравствуйте, чем я могу вам помочь?', 0, '2020-05-13 00:24:22');
    //CallFoo('Почему в магазинах нет красной икры?', 1, '2020-05-13 00:25:22');
    myDate :=  Now;
    for i := 0 to ( Memo1.Lines.Count - 1 ) do
     V := v + StringReplace(Memo1.Lines[i], '"', '\"',
                          [rfReplaceAll, rfIgnoreCase]) + '\r\n';DateTimeToString(formattedDateTime,'yyyy-mm-dd hh:nn:ss',myDate);
    CallFoo( v, 0, formattedDateTime);
    WebBrowser1.OleObject.Document.ParentWindow.ScrollBy(0, 1000);
    //ScrollBox1.VertScrollBar.Position:=ScrollBox1.VertScrollBar.Position+100;
end;


procedure TForm4.Image3Click(Sender: TObject);
begin
PopupMenu2.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TForm4.Label18Click(Sender: TObject);
begin
Form5.Show();
end;

procedure TForm4.Label24Click(Sender: TObject);
var
  l : TLabel;
  i : integer;
begin
  //ShowWindow(Handle1, SW_HIDE);
  Form6.Hide;
  l := Sender as TLabel;
  if (l.Parent as TPanel).Color = clWhite then
  begin
    TabbedNotebook1.PageIndex := 2;
    Dialogs.curuser := 0;
  end;

  DeleteDialogUser(GetDialogUserId((l.Parent as TPanel).Tag));
  l.Parent.Destroy;

end;

procedure TForm4.Label28Click(Sender: TObject);
begin
OpsSites.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TForm4.Label2Click(Sender: TObject);
begin
TabbedNotebook1.PageIndex := 0;
end;

procedure TForm4.Label3Click(Sender: TObject);
begin
TabbedNotebook1.PageIndex := 1;
end;

procedure TForm4.Label4Click(Sender: TObject);
begin
TabbedNotebook1.PageIndex := 2;
end;

procedure TForm4.Label5Click(Sender: TObject);
begin
TabbedNotebook1.PageIndex := 3;
end;

procedure TForm4.N1Click(Sender: TObject);
begin
   Memo1.Lines.Text := 'Здравствуйте, чем я могу вам помочь?';
end;

procedure TForm4.N2Click(Sender: TObject);
begin
   Memo1.Lines.Text := 'До свидания!';
end;

procedure TForm4.Panel14Click(Sender: TObject);
var
  I,i1: integer;
  document :IHTMLDocument2;
begin
  //ShowWindow(Handle1, SW_HIDE);
  Form6.Hide;
  i1 := -1;
  document := webBrowser1.Document as IHTMLDocument2;
  for I := 0 to ScrollBox1.ComponentCount-1 do
  begin
    if (ScrollBox1.Components[I] as TPanel).Color = clWhite then i1:=(ScrollBox1.Components[I] as TPanel).Tag;
    (ScrollBox1.Components[I] as TPanel).Color := clSilver;
  end;
  if i1 = -1 then
  begin
    if (Sender is TPanel) then i1 := ((Sender as TPanel).Tag)
    else
    if (Sender is TLabel) then i1 := (((Sender as TLabel).Parent as TPanel).Tag);
  end;


  if i1 > -1 then
  begin
    i := GetDialogUserId(i1);
    if Dialogs.curuser >0 then
    begin
      Dialogs.users[i].innerHTML := document.body.innerHTML;
      Dialogs.users[i].optypemsg := Memo1.Lines.Text;
      Dialogs.users[i].name := Edit1.Text;
      Dialogs.users[i].phone := Edit2.Text;
      Dialogs.users[i].email := Edit3.Text;
      Dialogs.users[i].comment := Memo2.Lines.Text;
    end;

    if(Sender is TPanel)then
    begin
      i := GetDialogUserId((Sender as TPanel).Tag);
    end
    else
     i := GetDialogUserId(((Sender as TLabel).Parent as TPanel).Tag);

    Dialogs.users[i].newmsgcnt := '';
    if(Sender is TPanel)then
    begin
     ((Sender as TPanel).Components[0] as TLabel).Caption := '';
    end
    else
    (((Sender as TLabel).Parent as TPanel).Components[0] as TLabel).Caption := '';

    Edit1.Text := Dialogs.users[i].name;
    Edit2.Text := Dialogs.users[i].phone;
    Edit3.Text := Dialogs.users[i].email;
    Memo2.Lines.Text := Dialogs.users[i].comment;
    Label7.Caption := Dialogs.users[i].ip;
    Label9.Caption := Dialogs.users[i].urlfrom;
    Label23.Caption := Dialogs.users[i].urlto;
    Label11.Caption := Dialogs.users[i].view;
    Label13.Caption := Dialogs.users[i].onsitetime;
    Label15.Caption := Dialogs.users[i].pageviews;
    Label17.Caption := Dialogs.users[i].visits;
    Memo1.Lines.Text := Dialogs.users[i].optypemsg;
    document.body.innerHTML := Dialogs.users[i].innerHTML;
    WebBrowser1.OleObject.Document.ParentWindow.ScrollBy(0, 1000);
    Dialogs.curuser := 1;
  end;
  if(Sender is TPanel)then
  begin
    (Sender as TPanel).Color := clWhite;
  end
  else
  ((Sender as TLabel).Parent as TPanel).Color := clWhite;

  TabbedNotebook1.PageIndex := 4;

//ShowMessage(p.Tag.ToString);
end;

procedure TForm4.Button1Click(Sender: TObject);
var
Buffer: String;
 HTTP: TIdHTTP;
 data: TIdMultiPartFormDataStream;

 S:String;
  I:Integer;
  JObj:TJSONObject;
  Pair : TJSONPair;
  SSL:TIdSSLIOHandlerSocketOpenSSL ;
begin
//splash_create();
data := TIdMultiPartFormDataStream.Create;
data.AddFormField('cookies', 'tger2shPXx');
  SSL:=TIdSSLIOHandlerSocketOpenSSL.Create(Application);
  SSL.ReadTimeOut:=10000;
  ///sslvSSLv2, sslvSSLv23, sslvSSLv3, sslvTLSv1,sslvTLSv1.sslvTLSv1_1,sslvTLSv1_2
  SSL.SSLOptions.Method:=sslvSSLv23;
  SSL.SSLOptions.Mode:=sslmUnassigned;
HTTP := TIdHTTP.Create;
  HTTP.ReadTimeout:=10000;
  HTTP.IOHandler:=SSL;
  HTTP.AllowCookies:=true;
Buffer := HTTP.Post('http://nachalosaita.itgroup.kz/sitesusers/updateuser.php',data);
//Buffer := HTTP.Get('https://stackoverflow.com/questions/27058054/delphi-how-to-parse-specified-values-from-http-get');
s := '{"series": "House of Cards", "episodeNumber": 3, "releaseGroup": "NTb", "format": "WEBRip", "season": 2'+', "audioCodec": "DolbyDigital", "year": 2013, "mimetype": "video/x-matroska", "container": "mkv", "videoCodec": "h264", "other": ["Netflix"]}';
  JObj := TJSONObject.ParseJSONValue(s) as TJSONObject;
  for I := 0 to TJSONArray(JObj).Count - 1 do
    begin
       Pair := TJSONPair(TJSONArray(JObj).Items[i]);
       Memo1.Lines.Add( Pair.JsonString.Value + '=' + Pair.JsonValue.ToString)
    end;
Showmessage(Buffer);
HTTP.Destroy;
end;


procedure TForm4.Button3Click(Sender: TObject);
begin
  InsertUserToDialogs(3,'8','Андрей','+380988988692','andrey@mail.ru',
      'Добавить комментарий','192.168.100.101','www.google.com','nachalosaita.itgroup.kz3','Программы',
      '1 час 2 мин.','12','3','Здравствуйте, чем я могу вам помочь?','<div class="style7" id="chatform"><div id="mainform" style="transform: translateY(0px);" height="100%"></div></div>');
   // ShowWindow(Handle, SW_RESTORE);
end;



procedure TForm4.Button4Click(Sender: TObject);
begin
Form6.FormShow;
end;

procedure TForm4.Exit1Click(Sender: TObject);
begin
 MustExit:=true;
 Close;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if MustExit then exit;
 Form4.Hide;
 Action:=caNone;
end;

procedure TForm4.InsertUserToDialogs(id: Integer;newmsgcnt: string;name: string; phone: string;
      email: string;comment: string;ip: string;urlfrom: string;urlto: string;view: string;
      onsitetime: string;pageviews: string;visits: string;optypemsg: string;innerHTML: WideString);
var
  i,j:integer;

panel : TPanel;
labelClose : TLabel;
labelName : TLabel;
labelEmail : TLabel;
labelMsgcount : TLabel;
document :IHTMLDocument2;
begin
  i := length(Dialogs.users);
  for j := 0 to length(Dialogs.users)-1 do
    begin
       if Dialogs.users[j].id = id then i := j;
    end;
  if i = length(Dialogs.users) then
  begin
    Dialogs.userscount := Dialogs.userscount + 1;

    panel :=TPanel.Create(nil);
    panel.Parent := ScrollBox1;
    panel.Align := alTop;
    if ScrollBox1.ComponentCount >0 then
    panel.Top := (ScrollBox1.Components[ScrollBox1.ComponentCount-1] as TPanel).Top;

    panel.Tag := id;
    panel.OnClick := Panel14Click;
    panel.ParentBackground := false;
    panel.Color := clSilver;
    panel.ShowCaption := false;

    labelClose :=TLabel.Create(nil);
    labelClose.Parent := panel;
    labelClose.Caption := 'x';
    labelClose.Align := alRight;
    labelClose.Width := 15;
    labelClose.Layout := tlCenter;
    labelClose.OnClick := Label24Click;

    labelName :=TLabel.Create(nil);
    labelName.Parent := panel; labelName.OnClick := Panel14Click;
    labelName.Caption := name;labelName.Left := 8;labelName.Top := 6;labelName.Width := 120;
    labelName.Font.Color := $006F5F5B; labelName.Font.Name := 'Arial'; labelName.Font.Height := -14;labelName.Font.Style := [fsBold];

    labelEmail :=TLabel.Create(nil);
    labelEmail.Parent := panel; labelEmail.OnClick := Panel14Click;
    labelEmail.Caption := email;labelEmail.Left := 7;labelEmail.Top := 23;labelEmail.Width := 120;
    labelEmail.Font.Color := $006F5F5B; labelEmail.Font.Name := 'Arial'; labelEmail.Font.Height := -13;

    labelMsgcount :=TLabel.Create(nil);
    labelMsgcount.Parent := panel; labelMsgcount.OnClick := Panel14Click;labelMsgcount.Align := alRight;
    labelMsgcount.Caption := newmsgcnt;labelMsgcount.Width := 15;labelMsgcount.Layout := tlCenter; labelMsgcount.AutoSize := false;
    labelMsgcount.Font.Color := clRed; labelMsgcount.Font.Name := 'Arial'; labelMsgcount.Font.Height := -12;labelMsgcount.Font.Style := [fsBold];

    panel.InsertComponent(labelMsgcount);

    ScrollBox1.InsertComponent(panel);
    ScrollBox1.Update;
    ScrollBox1.Invalidate;

    SetLength(Dialogs.users, length(Dialogs.users)+1);
    Form6.FormShow();
    //AnimateWindow(Handle1, 0, AW_BLEND);
  end
  else
  begin
    for j := 0 to ScrollBox1.ComponentCount-1 do
    begin
      if ((ScrollBox1.Components[j] as TPanel).Tag = Dialogs.users[i].id) and ((ScrollBox1.Components[j] as TPanel).Color <> clWhite) then
      begin
      ((ScrollBox1.Components[j] as TPanel).Components[0] as TLabel).Caption := newmsgcnt;
      document := webBrowser1.Document as IHTMLDocument2;
      document.body.innerHTML := innerHTML;
      WebBrowser1.OleObject.Document.ParentWindow.ScrollBy(0, 1000);
      Form6.FormShow();
      //AnimateWindow(Handle1, 0, AW_BLEND);
      end;
    end;
  end;
  Dialogs.users[i].id := id;
  Dialogs.users[i].newmsgcnt := newmsgcnt;
  Dialogs.users[i].name := name;
  Dialogs.users[i].phone := phone;
  Dialogs.users[i].email := email;
  Dialogs.users[i].comment := comment;
  Dialogs.users[i].ip := ip;
  Dialogs.users[i].urlfrom := urlfrom;
  Dialogs.users[i].urlto := urlto;
  Dialogs.users[i].view := view;
  Dialogs.users[i].onsitetime := onsitetime;
  Dialogs.users[i].pageviews := pageviews;
  Dialogs.users[i].visits := visits;
  Dialogs.users[i].optypemsg := optypemsg;
  Dialogs.users[i].innerHTML := innerHTML;
end;
function TForm4.GetDialogUserId(i: integer):integer;
var j:integer;
begin
  for j := 0 to length(Dialogs.users)-1 do
    begin
       if Dialogs.users[j].id = i then Result := j;
    end;
end;
procedure TForm4.DeleteDialogUser( const pos:integer);
var
   lg, j : integer;
begin
   lg := length(Dialogs.users);
   if pos > lg-1 then
     exit
   else if pos = lg-1 then begin
           Setlength(Dialogs.users, lg -1);
           exit;
        end;
   for j := pos to lg-2 do
     Dialogs.users[j] := Dialogs.users[j+1];
   SetLength(Dialogs.users, lg-1);
end;
end.