unit Unit4;
//{ //$ //R Project1.REC}
interface

uses
  Registry,ShlObj,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellAPI, StdCtrls, Menus, Vcl.ExtCtrls, IdHTTP, IdMultipartFormData, System.JSON, Rest.JSON,
  IdSSL, IdSSLOpenSSL,System.Generics.Collections,MSHTML,JPEG,IniFiles,IdComponent, IdTCPConnection, IdTCPClient,
  System.Net.URLClient, System.Net.HttpClient, Soap.SOAPHTTPTrans, Vcl.OleCtrls,DateUtils,
  SHDocVw, Vcl.Imaging.pngimage, Vcl.Tabs, Vcl.ComCtrls, Vcl.TabNotBk,Unit5,Unit6,Unit7,Unit8,StrUtils;

const WM_ICONTRAY = WM_USER+1;
type TUserSB = record
 id:integer;
 name:string;
 phone:string;
 email:string;
 comment:WideString;
 ip:string;
 urlfrom:string;
 urlto:string;
 view:string;
 onsitetime:string;
 pageviews:string;
 visits:string;
 dialogscnt:string;
 opname:string;
 opjpg:string;
 msgtime:string;
 visittime:string;
end;
type
  TStartOTUD = array of record
  msg:string;
  dtime:string;
  toop:string;
end;
function getOTUD(id: integer): TStartOTUD1;
type
  TDepartments = array of record
  department:string;
end;
type
  TSitesArray = array of record
  id:string;
  site:string;
  department:TDepartments;
end;
type
 TDepts = array of record
  dept:string[50];
 end;
type
 TSitesDepts = array of record
  domain:string[50];
  depts:TDepts;
 end;
type
 TOperators = array of record
  id:integer;
  name:string;
  status:string;
  jpgname:string;
  //domain:WideString;
  //department:WideString;
  sitesdepts:TSitesDepts;
 end;
function getSites(JsonString: String): TSitesArray;
function getJSONItem(JsonString: String; Field: String): String;
procedure Updates(hWnd1: HWND; uMsg: UINT; idEvent: UINT_PTR; dwTime: DWORD); stdcall;
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
    Panel4: TPanel;
    Label1: TLabel;
    Panel11: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Label20: TLabel;
    Label21: TLabel;
    PopupMenu2: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    OpsSites: TPopupMenu;
    N3: TMenuItem;
    InDialogPNG: TImage;
    VisitorPNG: TImage;
    DialogRequest: TImage;
    AllUsers: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    UsersSites: TPopupMenu;
    Image20: TImage;
    Panel5: TPanel;
    PageControl1: TPageControl;
    TabSheet0: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet1: TTabSheet;
    TabSheet4: TTabSheet;
    Panel6: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Label22: TLabel;
    Label23: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Memo2: TMemo;
    Button2: TButton;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel23: TPanel;
    Panel9: TPanel;
    Panel22: TPanel;
    Panel24: TPanel;
    Panel10: TPanel;
    Panel25: TPanel;
    WebBrowser1: TWebBrowser;
    Panel20: TPanel;
    Label25: TLabel;
    Label26: TLabel;
    Panel21: TPanel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Panel15: TPanel;
    Label27: TLabel;
    Label28: TLabel;
    ScrollBox2: TScrollBox;
    Panel16: TPanel;
    Panel18: TPanel;
    Panel7: TPanel;
    Panel14: TPanel;
    Label24: TLabel;
    Panel19: TPanel;
    ScrollBox3: TScrollBox;
    ScrollBox4: TScrollBox;
    Panel8: TPanel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Departments: TPopupMenu;
    Image21: TImage;
    N8: TMenuItem;
    MissedPNG: TImage;
    Memo1: TMemo;
    Image3: TImage;
    Image2: TImage;
    Memo3: TMemo;
    procedure TrayMessage(var Msg: TMessage); message WM_ICONTRAY;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ShowForm4Click(Sender: TObject);
    procedure HideForm4Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CallFoo(const S: string; I: Integer;T: string);
    procedure Image2Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Panel14Click(Sender: TObject);
    procedure Label24Click(Sender: TObject);
    procedure InsertUserToDialogs(id: Integer;newmsgcnt: string;name: string; phone: string;
      email: string;comment: string;ip: string;urlfrom: string;urlto: string;view: string;
      onsitetime: string;pageviews: string;visits: string;optypemsg: string;innerHTML: WideString;msgtime:string;visittime:string);
    function GetDialogUserId (i:integer) : integer;
    procedure DeleteDialogUser( const pos:integer);
    procedure DeleteUser( const pos:integer);
    procedure FormShow(Sender: TObject);
    procedure Label18Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure DownloadJPG(url:string;im:TImage);
    procedure InsertOpToScrollBox(id:integer;name:string;status:string;jpgname:string;sitesdepts:TSitesDepts);
    procedure ScrollBox2Resize(Sender: TObject);
    procedure InsertSiteToScrollBox(id:integer;domain:string);
    procedure LabelSiteClose(Sender: TObject);
    procedure Label28Click(Sender: TObject);
    procedure HandleOpsSites(Sender: TObject);
    procedure HandleDepartments(Sender: TObject);
    procedure HandleOpsSitesDepartments();
    procedure InsertUserToScrollBox(usb:TUserSB);
    procedure Label25Click(Sender: TObject);
    procedure UserPanelClick(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure Label26Click(Sender: TObject);
    procedure HandleUsersSites();
    procedure menu1OnDrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure Label19Click(Sender: TObject);
    procedure Label35Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PageControl1Resize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure StartMainTimer();
   // function getData2(JsonString: String; User: String; Field: String): String;


//    procedure CreateParams (var Params: TCreateParams); override;
 // private
  public
   TrayIconData: TNotifyIconData;
  end;
  THTTPThread = class(TThread)
    private
    { Private declarations }
   // procedure OnWork(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
  protected
    procedure Execute; override;
  end;
  THTTPThread1 = class(TThread)
    private
    { Private declarations }
   // procedure OnWork(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
  protected
    procedure Execute; override;
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
  msgtime     : string[35];
  visittime     : string[35];
  msgs     : WideString;
 end;
type
 TUrlCash = array of record
  jpg : TMemoryStream;
  jpgName : string[30];
 end;

type TUsersDialog = record
 users : TUserDialog;
 userscount,curuser : integer;
 end;
type TUserTyping = record
 watch : string;
 onsitetime : string;
 pageviews : string;
 visits : string;
 usrtyping : string;
 end;
type
  TUsersSB = array of TUserSB;
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
  QueueUpdates : Integer = 0;
  UpdatesFlag : boolean = false;
  CursorPos : TPoint;
  OfflineCounter : integer;
  Cookie : string;
  MibewSessionID : string;
  mibew_operator : string;
  OperatorID : string;
  UrlCash : TUrlCash;
  Operators : TOperators;
  Sites: TSitesArray;
  Ops1 : TOperators;
  Users : array of TUserSB;
  NeedExit : boolean;
  LastChatMessage:string;
  LastChatStatusMessage:integer;
  LastChatUserId:integer;
  httpThread: THTTPThread;
  GlobalHTTP: TIdHTTP;
  Globaldata: TIdMultiPartFormDataStream;
  GlobalHTTPok: boolean;
  GlobalBuffer: string;
  GlobalUrl: string;

  httpThread1: THTTPThread1;
  GlobalHTTP1: TIdHTTP;
  Globaldata1: TIdMultiPartFormDataStream;
  GlobalHTTPok1: boolean;
  GlobalBuffer1: string;
  GlobalUrl1: string;

  KeepOnlineInterval:integer;

  NeedExit2: boolean;



implementation
uses Types;
{$R *.dfm}


function getOTUD(id: integer): TStartOTUD1;
var
  JSonValue: TJSonValue;
  JsonArray: TJSONArray;
  ArrayElement: TJSonValue;

 Buffer: String;
 HTTP: TIdHTTP;
 data: TIdMultiPartFormDataStream;
 SSL:TIdSSLIOHandlerSocketOpenSSL;
 StartOTUD:TStartOTUD;
begin
  data := TIdMultiPartFormDataStream.Create;
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

  data := TIdMultiPartFormDataStream.Create;
  data.AddFormField('csrf_token', Cookie);
  data.AddFormField('userid', id.ToString);
//   try
//    Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/user/open',data);
//   except
//    //ShowMessage('Отсутствует связь с сервером' + #10#13);
//    Exit;
//   end;

 GlobalUrl1 := 'https://test3.console.vipsite.kz/api-chat/user/open';
GlobalHTTPok1 := false;GlobalHTTP1 := HTTP;Globaldata1 := data;
httpThread1:=THTTPThread1.Create(false);
while GlobalHTTPok1 = false do begin Sleep(10);Application.ProcessMessages;end;
Buffer:=GlobalBuffer1;

  SetLength(Result,0);
  JsonValue := TJSonObject.ParseJSONValue(Buffer);
  try
  JsonArray := JsonValue.GetValue<TJSONArray>('dialogs');
  for ArrayElement in JsonArray do begin
        SetLength(Result,length(Result)+1);
        Result[length(Result)-1].msg := ArrayElement.GetValue<String>('msg');
        Result[length(Result)-1].dtime := ArrayElement.GetValue<String>('dtime');
        Result[length(Result)-1].toop := ArrayElement.GetValue<String>('toop');
  end;
  except

  end;
  HTTP.Destroy;
  SSL.Destroy;
end;

procedure TForm4.HandleUsersSites();
var
i,j:integer;
panel : TPanel;
labelName : TLabel;
labelView : TLabel;
labelOnsitetime : TLabel;
labelOperator : TLabel;
labelDialogsCnt : TLabel;
labelPageViewsCnt : TLabel;
labelVisitsCnt : TLabel;
img,opJPG : TImage;
PNGStream : TMemoryStream;

FmtStngs: TFormatSettings;
TimeInfo:_TIME_ZONE_INFORMATION;
dtime,dtimecurrent:TDateTime;
begin
dtimecurrent := Now;
GetTimeZoneInformation(TimeInfo);
GetLocaleFormatSettings( GetThreadLocale, FmtStngs );
FmtStngs.DateSeparator := '-';
FmtStngs.ShortDateFormat := 'yyyy-mm-dd';
FmtStngs.TimeSeparator := ':';
FmtStngs.LongTimeFormat := 'hh:nn:ss';

  ScrollBox4.DestroyComponents;
  for i := 0 to length(Users)-1 do
    begin
      if ((Label26.Caption = Users[i].urlto) or (Label26.Caption = 'Все сайты'))
      and ((Label25.Caption = 'Все посетители') or ((Users[i].opname <> '') and (Label25.Caption = 'В чате'))
          or ((Users[i].opname = '') and (Users[i].dialogscnt = '0') and (Label25.Caption = 'Новые посетители'))
//          or (((Users[i].opname = '') and (StrToInt(Users[i].dialogscnt) > 0)) and ((Label25.Caption = 'Запрос диалога')))) then
      or ((MinutesBetween(dtimecurrent,IncMinute(StrToDateTime(Users[i].visittime,FmtStngs),TimeInfo.Bias*-1))>1)and(Label25.Caption = 'Пропущенные обращения'))
      or ((Users[i].opname = '') and (MinutesBetween(dtimecurrent,IncMinute(StrToDateTime(Users[i].visittime,FmtStngs),TimeInfo.Bias*-1))<1) and (Label25.Caption = 'Запрос диалога'))) then

      begin
        panel :=TPanel.Create(nil);
        panel.Parent := ScrollBox4;
        panel.Align := alTop;

        panel.Tag := Users[i].id;
    //    panel.OnClick := usbClick;
        panel.ParentBackground := false;
        panel.ParentFont := false;
        if ScrollBox4.ComponentCount = (Trunc(ScrollBox4.ComponentCount/2)*2) then
          panel.Color := $00EEEEEE else panel.Color := clWhite;
        panel.ShowCaption := false; panel.OnClick := UserPanelClick;
        panel.Height := 34;

        labelName :=TLabel.Create(nil);
        labelName.Parent := panel; labelName.OnClick := UserPanelClick;
        if Users[i].name= '' then labelName.Caption := Users[i].ip else labelName.Caption := Users[i].name;
        labelName.Left := 14;labelName.Top := 8;
        labelName.Font.Color := $00705F5B; labelName.Font.Name := 'Arial'; labelName.Font.Height := -12;
        panel.InsertComponent(labelName);

        img :=TImage.Create(nil);
        img.Parent := panel;
        img.Align := alNone;  img.OnClick := UserPanelClick;
        img.Left := 222;img.Top := 6;img.Width := 32;img.Height := 32;

        PNGStream := TMemoryStream.Create;PNGStream.Position := 0;
        if Users[i].opname <> '' then inDialogPNG.Picture.SaveToStream(PNGStream)
          else
          if (Users[i].opname = '') and (Users[i].dialogscnt = '0') then VisitorPNG.Picture.SaveToStream(PNGStream)
          else if MinutesBetween(dtimecurrent,IncMinute(StrToDateTime(Users[i].visittime,FmtStngs),TimeInfo.Bias*-1))>1 then MissedPNG.Picture.SaveToStream(PNGStream)
          else if ((Users[i].opname = '') and (Users[i].dialogscnt = '1')) then DialogRequest.Picture.SaveToStream(PNGStream);
        PNGStream.Position := 0;
        img.Picture.LoadFromStream(PNGStream);PNGStream.Free;
        panel.InsertComponent(img);

        labelView :=TLabel.Create(nil);
        labelView.Parent := panel; labelView.OnClick := UserPanelClick;
        labelView.Caption := Users[i].view;
        labelView.AutoSize := false;
        labelView.Width := 185;
        labelView.Left := 300;labelView.Top := 8;
        labelView.Font.Color := $00705F5B; labelView.Font.Name := 'Arial'; labelView.Font.Height := -12;
        panel.InsertComponent(labelView);

        labelOnsitetime :=TLabel.Create(nil);
        labelOnsitetime.Parent := panel; labelOnsitetime.OnClick := UserPanelClick;
        labelOnsitetime.Caption := Users[i].onsitetime;
        labelOnsitetime.Left := 490;labelOnsitetime.Top := 8;
        labelOnsitetime.Font.Color := $00705F5B; labelOnsitetime.Font.Name := 'Arial'; labelOnsitetime.Font.Height := -12;
        panel.InsertComponent(labelOnsitetime);

        opJPG :=TImage.Create(nil);
        opJPG.Parent := panel;
        opJPG.Align := alNone;opJPG.OnClick := UserPanelClick;
        opJPG.Left := 615;opJPG.Top := 0;opJPG.Width := 32;opJPG.Height := 32;
        if Users[i].opjpg <>'' then DownloadJPG(Users[i].opjpg,opJPG);
        panel.InsertComponent(opJPG);

        labelOperator :=TLabel.Create(nil);
        labelOperator.Parent := panel; labelOperator.OnClick := UserPanelClick;
        labelOperator.Caption := Users[i].opname;
        labelOperator.Left := 655;labelOperator.Top := 8;
        labelOperator.Font.Color := $00705F5B; labelOperator.Font.Name := 'Arial'; labelOperator.Font.Height := -12;
        panel.InsertComponent(labelOperator);

        labelDialogsCnt :=TLabel.Create(nil);
        labelDialogsCnt.Parent := panel; labelDialogsCnt.OnClick := UserPanelClick;
        labelDialogsCnt.Caption := Users[i].dialogscnt;
        labelDialogsCnt.Alignment := taCenter; labelDialogsCnt.Width := 25; labelDialogsCnt.AutoSize := false;
        labelDialogsCnt.Left := 768;labelDialogsCnt.Top := 8;
        labelDialogsCnt.Font.Color := $00705F5B; labelDialogsCnt.Font.Name := 'Arial'; labelDialogsCnt.Font.Height := -12;
        panel.InsertComponent(labelDialogsCnt);

        labelPageViewsCnt :=TLabel.Create(nil);
        labelPageViewsCnt.Parent := panel; labelPageViewsCnt.OnClick := UserPanelClick;
        labelPageViewsCnt.Caption := Users[i].pageviews;
        labelPageViewsCnt.Alignment := taCenter; labelPageViewsCnt.Width := 25; labelPageViewsCnt.AutoSize := false;
        labelPageViewsCnt.Left := 799;labelPageViewsCnt.Top := 8;
        labelPageViewsCnt.Font.Color := $00705F5B; labelPageViewsCnt.Font.Name := 'Arial'; labelPageViewsCnt.Font.Height := -12;
        panel.InsertComponent(labelPageViewsCnt);

        labelVisitsCnt :=TLabel.Create(nil);
        labelVisitsCnt.Parent := panel; labelVisitsCnt.OnClick := UserPanelClick;
        labelVisitsCnt.Caption := Users[i].visits; labelVisitsCnt.Alignment := taCenter; labelVisitsCnt.Width := 25; labelVisitsCnt.AutoSize := false;
        labelVisitsCnt.Left := 832;labelVisitsCnt.Top := 8;
        labelVisitsCnt.Font.Color := $00705F5B; labelVisitsCnt.Font.Name := 'Arial'; labelVisitsCnt.Font.Height := -12;
        panel.InsertComponent(labelVisitsCnt);

    //    panel.InsertComponent(labelMsgcount);

        ScrollBox4.InsertComponent(panel);
        ScrollBox4.Update;
        ScrollBox4.Invalidate;
        Form6.FormShow('',labelName.Caption,labelView.Caption);//НОВЫЙ ПОЛЬЗОВАТЕЛЬ
      end;
    end;

  //MessageDlg(TMenuItem(Sender).Caption,mtCustom,[mbYes,mbAll,mbCancel], 0);
end;
procedure TForm4.UserPanelClick(Sender: TObject);
var
  UserSB : TUserSB1;
  i,i1:integer;
begin
Form7.Show;
Form7.Left := Mouse.CursorPos.X;
if Screen.Height > (Mouse.CursorPos.Y+Form7.Height+60) then Form7.Top := Mouse.CursorPos.Y
 else Form7.Top := Screen.Height-Form7.Height-60;

  if(Sender is TPanel) then i1:= (Sender as TPanel).Tag else if(Sender is TLabel) then i1:=(Sender as TLabel).Parent.Tag else i1:=(Sender as TImage).Parent.Tag;
  for i := 0 to length(Users)-1 do
  if Users[i].id = i1 then
  begin
  UserSB.id := Users[i].id;
  UserSB.name := Users[i].name;
  UserSB.phone := Users[i].phone;
  UserSB.email := Users[i].email;
  UserSB.comment := Users[i].comment;
  UserSB.ip := Users[i].ip;
  UserSB.urlfrom := Users[i].urlfrom;
  UserSB.urlto := Users[i].urlto;
  UserSB.view := Users[i].view;
  UserSB.onsitetime := Users[i].onsitetime;
  UserSB.pageviews := Users[i].pageviews;
  UserSB.visits := Users[i].visits;
  UserSB.dialogscnt := Users[i].dialogscnt;
  UserSB.opname := Users[i].opname;
  UserSB.opjpg := Users[i].opjpg;
  UserSB.msgtime := Users[i].msgtime;
  UserSB.visittime := Users[i].visittime;
  Form7.SetUserInfo(UserSB);
  end;
end;
procedure TForm4.InsertUserToScrollBox(usb:TUserSB);
var
i,j,i1:integer;
panel : TPanel;
labelName : TLabel;
labelView : TLabel;
labelOnsitetime : TLabel;
labelOperator : TLabel;
labelDialogsCnt : TLabel;
labelPageViewsCnt : TLabel;
labelVisitsCnt : TLabel;
img,opJPG : TImage;
PNGStream : TMemoryStream;

FmtStngs: TFormatSettings;
TimeInfo:_TIME_ZONE_INFORMATION;
dtime,dtimecurrent:TDateTime;
begin
dtimecurrent := Now;
GetTimeZoneInformation(TimeInfo);
GetLocaleFormatSettings( GetThreadLocale, FmtStngs );
FmtStngs.DateSeparator := '-';
FmtStngs.ShortDateFormat := 'yyyy-mm-dd';
FmtStngs.TimeSeparator := ':';
FmtStngs.LongTimeFormat := 'hh:nn:ss';

i := -1;//length(Users);
for j := 0 to length(Users)-1 do
  begin
     if Users[j].id = usb.id then i := j;
  end;
if i=-1 then
begin

  if ((Label26.Caption = usb.urlto) or (Label26.Caption = 'Все сайты'))
  and ((Label25.Caption = 'Все посетители') or ((usb.opname <> '') and ((Label25.Caption = 'В чате')))
      or ((usb.opname = '') and (usb.dialogscnt = '0') and (Label25.Caption = 'Новые посетители'))
      or ((MinutesBetween(dtimecurrent,IncMinute(StrToDateTime(usb.visittime,FmtStngs),TimeInfo.Bias*-1))>1)and(Label25.Caption = 'Пропущенные обращения'))
      or ((usb.opname = '') and (MinutesBetween(dtimecurrent,IncMinute(StrToDateTime(usb.visittime,FmtStngs),TimeInfo.Bias*-1))<1) and (Label25.Caption = 'Запрос диалога'))) then
  begin
    i:=length(Users);
    SetLength(Users, i+1);
    panel :=TPanel.Create(nil);
    panel.Parent := ScrollBox4;
    panel.Align := alTop;

    panel.Tag := usb.id;
//    panel.OnClick := usbClick;
    panel.ParentBackground := false;
    if ScrollBox4.ComponentCount = (Trunc(ScrollBox4.ComponentCount/2)*2) then
      panel.Color := $00EEEEEE else panel.Color := clWhite;
    panel.ShowCaption := false; panel.OnClick := UserPanelClick;
    panel.Height := 34;

    labelName :=TLabel.Create(nil);
    labelName.Parent := panel; labelName.OnClick := UserPanelClick;
    if usb.name= '' then labelName.Caption := usb.ip else labelName.Caption := usb.name;
    labelName.Left := 14;labelName.Top := 8;
    labelName.Font.Color := $00705F5B; labelName.Font.Name := 'Arial'; labelName.Font.Height := -12;
    panel.InsertComponent(labelName);

    img :=TImage.Create(nil);
    img.Parent := panel;
    img.Align := alNone;  img.OnClick := UserPanelClick;
    img.Left := 222;img.Top := 6;img.Width := 32;img.Height := 32;


    PNGStream := TMemoryStream.Create;PNGStream.Position := 0;
    if usb.opname <> '' then inDialogPNG.Picture.SaveToStream(PNGStream)
      else if (usb.opname = '') and (usb.dialogscnt = '0') then VisitorPNG.Picture.SaveToStream(PNGStream)
      else if MinutesBetween(dtimecurrent,IncMinute(StrToDateTime(usb.visittime,FmtStngs),TimeInfo.Bias*-1))>1 then MissedPNG.Picture.SaveToStream(PNGStream)
      else DialogRequest.Picture.SaveToStream(PNGStream);
    PNGStream.Position := 0;PNGStream.Clear;
    img.Picture.LoadFromStream(PNGStream);PNGStream.Free;

    panel.InsertComponent(img);

    labelView :=TLabel.Create(nil);
    labelView.Parent := panel; labelView.OnClick := UserPanelClick;
    labelView.Caption := usb.view;
    labelView.AutoSize := false;
    labelView.Width := 185;
    labelView.Left := 300;labelView.Top := 8;
    labelView.Font.Color := $00705F5B; labelView.Font.Name := 'Arial'; labelView.Font.Height := -12;
    panel.InsertComponent(labelView);

    labelOnsitetime :=TLabel.Create(nil);
    labelOnsitetime.Parent := panel; labelOnsitetime.OnClick := UserPanelClick;
    labelOnsitetime.Caption := usb.onsitetime;
    labelOnsitetime.Left := 490;labelOnsitetime.Top := 8;
    labelOnsitetime.Font.Color := $00705F5B; labelOnsitetime.Font.Name := 'Arial'; labelOnsitetime.Font.Height := -12;
    panel.InsertComponent(labelOnsitetime);

    opJPG :=TImage.Create(nil);
    opJPG.Parent := panel;
    opJPG.Align := alNone;opJPG.OnClick := UserPanelClick;
    opJPG.Left := 615;opJPG.Top := 0;opJPG.Width := 32;opJPG.Height := 32;
    if usb.opjpg <>'' then DownloadJPG(usb.opjpg,opJPG);
    panel.InsertComponent(opJPG);

    labelOperator :=TLabel.Create(nil);
    labelOperator.Parent := panel; labelOperator.OnClick := UserPanelClick;
    labelOperator.Caption := usb.opname;
    labelOperator.Left := 655;labelOperator.Top := 8;
    labelOperator.Font.Color := $00705F5B; labelOperator.Font.Name := 'Arial'; labelOperator.Font.Height := -12;
    panel.InsertComponent(labelOperator);

    labelDialogsCnt :=TLabel.Create(nil);
    labelDialogsCnt.Parent := panel; labelDialogsCnt.OnClick := UserPanelClick;
    labelDialogsCnt.Caption := usb.dialogscnt;
    labelDialogsCnt.Alignment := taCenter; labelDialogsCnt.Width := 25; labelDialogsCnt.AutoSize := false;
    labelDialogsCnt.Left := 768;labelDialogsCnt.Top := 8;
    labelDialogsCnt.Font.Color := $00705F5B; labelDialogsCnt.Font.Name := 'Arial'; labelDialogsCnt.Font.Height := -12;
    panel.InsertComponent(labelDialogsCnt);

    labelPageViewsCnt :=TLabel.Create(nil);
    labelPageViewsCnt.Parent := panel; labelPageViewsCnt.OnClick := UserPanelClick;
    labelPageViewsCnt.Caption := usb.pageviews;
    labelPageViewsCnt.Alignment := taCenter; labelPageViewsCnt.Width := 25; labelPageViewsCnt.AutoSize := false;
    labelPageViewsCnt.Left := 799;labelPageViewsCnt.Top := 8;
    labelPageViewsCnt.Font.Color := $00705F5B; labelPageViewsCnt.Font.Name := 'Arial'; labelPageViewsCnt.Font.Height := -12;
    panel.InsertComponent(labelPageViewsCnt);

    labelVisitsCnt :=TLabel.Create(nil);
    labelVisitsCnt.Parent := panel; labelVisitsCnt.OnClick := UserPanelClick;
    labelVisitsCnt.Caption := usb.visits; labelVisitsCnt.Alignment := taCenter; labelVisitsCnt.Width := 25; labelVisitsCnt.AutoSize := false;
    labelVisitsCnt.Left := 832;labelVisitsCnt.Top := 8;
    labelVisitsCnt.Font.Color := $00705F5B; labelVisitsCnt.Font.Name := 'Arial'; labelVisitsCnt.Font.Height := -12;
    panel.InsertComponent(labelVisitsCnt);

//    panel.InsertComponent(labelMsgcount);
    Form6.FormShow('',labelName.Caption,labelView.Caption);//НОВЫЙ ПОЛЬЗОВАТЕЛЬ
    ScrollBox4.InsertComponent(panel);
    ScrollBox4.Update;
    ScrollBox4.Invalidate;
  end;
end
else
begin
  for j := 0 to ScrollBox4.ComponentCount-1 do
  begin
    if (ScrollBox4.Components[j] as TPanel).Tag = usb.id then
    begin
    if usb.name= '' then
      ((ScrollBox4.Components[j] as TPanel).Components[0] as TLabel).Caption :=usb.ip
      else
      ((ScrollBox4.Components[j] as TPanel).Components[0] as TLabel).Caption :=usb.name;

    PNGStream := TMemoryStream.Create;PNGStream.Position := 0;
    if usb.opname <> '' then inDialogPNG.Picture.SaveToStream(PNGStream)
      else if (usb.opname = '') and (usb.dialogscnt = '0') then VisitorPNG.Picture.SaveToStream(PNGStream)
      else if MinutesBetween(dtimecurrent,IncMinute(StrToDateTime(usb.visittime,FmtStngs),TimeInfo.Bias*-1))>1 then MissedPNG.Picture.SaveToStream(PNGStream)
      else DialogRequest.Picture.SaveToStream(PNGStream);
    PNGStream.Position := 0;
    ((ScrollBox4.Components[j] as TPanel).Components[1] as TImage).Picture.LoadFromStream(PNGStream);PNGStream.Free;

    ((ScrollBox4.Components[j] as TPanel).Components[2] as TLabel).Caption :=usb.view;
    ((ScrollBox4.Components[j] as TPanel).Components[3] as TLabel).Caption :=usb.onsitetime;

    if usb.opjpg <>'' then DownloadJPG(usb.opjpg,((ScrollBox4.Components[j] as TPanel).Components[4] as TImage))
    else ((ScrollBox4.Components[j] as TPanel).Components[4] as TImage).Picture := nil;

    ((ScrollBox4.Components[j] as TPanel).Components[5] as TLabel).Caption :=usb.opname;
    if((usb.opname='') AND (((ScrollBox4.Components[j] as TPanel).Components[6] as TLabel).Caption <>usb.dialogscnt)) then
    Form6.FormShow('',((ScrollBox4.Components[j] as TPanel).Components[0] as TLabel).Caption,usb.view);//ВХОДЯЩЕЕ СООБЩЕНИЕ
    ((ScrollBox4.Components[j] as TPanel).Components[6] as TLabel).Caption :=usb.dialogscnt;
    ((ScrollBox4.Components[j] as TPanel).Components[7] as TLabel).Caption :=usb.pageviews;
    ((ScrollBox4.Components[j] as TPanel).Components[8] as TLabel).Caption :=usb.visits;

    ScrollBox4.Update;
    ScrollBox4.Invalidate;
    end;
  end;
end;
if (length(Users)>0) and (i<>-1) then
begin
    Users[i].id := usb.id;
    Users[i].name := usb.name;
    Users[i].phone := usb.phone;
    Users[i].email := usb.email;
    Users[i].comment := usb.comment;
    Users[i].ip := usb.ip;
    Users[i].urlfrom := usb.urlfrom;
    Users[i].urlto := usb.urlto;
    Users[i].view := usb.view;
    Users[i].onsitetime := usb.onsitetime;
    Users[i].pageviews := usb.pageviews;
    Users[i].visits := usb.visits;
    Users[i].dialogscnt := usb.dialogscnt;
    Users[i].opname := usb.opname;
    Users[i].opjpg := usb.opjpg;
    Users[i].msgtime := usb.msgtime;
    Users[i].visittime := usb.visittime;
end;

end;
procedure TForm4.HandleOpsSites(Sender: TObject);
var
i,i1 : integer;
Item:TMenuItem;
begin
  Label28.Caption := TMenuItem(Sender).Caption;
  Form4.Departments.Items.Clear;
  for i := 0 to length(Sites)-1 do
  begin
    if Sites[i].site = Label28.Caption then
    begin
      Form4.Departments.Items.Clear;
      for i1 := 0 to length(Sites[i].department)-1 do
      begin
        Item := TMenuItem.Create(Form4.Departments);
        Item.Caption := Sites[i].department[i1].department;
        Item.OnClick := HandleDepartments;
        Item.OnDrawItem := menu1OnDrawItem;
        Departments.OwnerDraw := true;
        Departments.Items.Add(Item);
      end;
    end;
  end;
  Item := TMenuItem.Create(Form4.Departments);
  Item.Caption := '-';
  Item.OnClick := Form4.HandleDepartments;
  Item.OnDrawItem := Form4.menu1OnDrawItem;
  Form4.Departments.OwnerDraw := true;
  Form4.Departments.Items.Add(Item);
  Item := TMenuItem.Create(Form4.Departments);
  Item.Caption := 'Все отделы';
  Item.OnClick := Form4.HandleDepartments;
  Item.OnDrawItem := Form4.menu1OnDrawItem;
  Form4.Departments.OwnerDraw := true;
  Form4.Departments.Items.Add(Item);
  HandleOpsSitesDepartments();
end;
procedure TForm4.HandleDepartments(Sender: TObject);
begin
   Label35.Caption := TMenuItem(Sender).Caption;
   HandleOpsSitesDepartments();
end;
procedure TForm4.HandleOpsSitesDepartments();
var
panel : TPanel;
labelName : TLabel;
labelStatus : TLabel;
labelDomain : TLabel;
img : TImage;
i,i1,i2:integer;
opindept,opindomain:boolean;
begin

  ScrollBox2.DestroyComponents;
  for i := 0 to length(Operators)-1 do
    begin
      opindept := false; opindomain := false;
      for i1 := 0 to length(Operators[i].sitesdepts)-1 do
      begin
      if Operators[i].sitesdepts[i1].domain = Label28.Caption then opindomain := true;
      for i2 := 0 to length(Operators[i].sitesdepts[i1].depts)-1 do
           if (Operators[i].sitesdepts[i1].domain = Label28.Caption) and (Operators[i].sitesdepts[i1].depts[i2].dept = Label35.Caption) then
              opindept := true;
      end;
      //if ((Pos(WideString(#39+Label28.Caption+#39),Operators[i].domain)>0) or (Label28.Caption = 'Всех сайтах'))and ((Pos(WideString(#39+Label35.Caption+#39),Operators[i].department)>0) or (Label35.Caption = 'Все отделы')) then
      if ((opindomain) or (Label28.Caption = 'Всех сайтах'))and ((opindept) or (Label35.Caption = 'Все отделы')) then
      begin

        panel :=TPanel.Create(nil);
        panel.Parent := ScrollBox2;
        panel.Align := alNone;
        panel.Top := Trunc(ScrollBox2.ComponentCount / Trunc(ScrollBox2.ClientWidth / 130)) * 50 + 10;
        panel.Left := (ScrollBox2.ComponentCount - (Trunc(ScrollBox2.ComponentCount / Trunc(ScrollBox2.ClientWidth / 130))*Trunc(ScrollBox2.ClientWidth / 130)))* 130 + 10;
        panel.Tag := Operators[i].id;
     //   panel.OnClick := Panel14Click;
        panel.ParentBackground := false;
        //panel.Color := $00EEEEEE;
        panel.ShowCaption := false;
        panel.Width := 120;
        panel.Color := clWhite;
        panel.BevelOuter := bvNone;
        panel.Height := 40;

        labelName :=TLabel.Create(nil);
        labelName.Parent := panel;
        labelName.Caption := Operators[i].name;
        labelName.Align := alNone;
        labelName.Left := 38;
        labelName.Top := 2; labelName.Font.Color := $00675551;
        labelName.Font.Name := 'Arial'; labelName.Font.Height := -12;
    //    labelName.OnClick := Label24Click;

        labelStatus :=TLabel.Create(nil);
        labelStatus.Parent := panel; //labelName.OnClick := Panel14Click;
        labelStatus.Caption := Operators[i].status;labelStatus.Left := 38;labelStatus.Top := 15;
        if Operators[i].status = 'В сети' then
         labelStatus.Font.Color := $0065BA34
         else labelStatus.Font.Color := $002168EB;
        labelStatus.Font.Name := 'Arial'; labelStatus.Font.Height := -12;labelStatus.Font.Style := [fsBold];

//        labelDomain := TLabel.Create(nil);
//        labelDomain.Parent := panel;
//        labelDomain.Caption := Operators[i].domain;
//        labelDomain.Visible := false;
//        panel.InsertComponent(labelDomain);

        img :=TImage.Create(nil);
        img.Parent := panel;
        img.Align := alNone;
        img.Left := 0;img.Top := 0;img.Width := 32;img.Height := 32;
        if Operators[i].jpgname <> '' then DownloadJPG(Operators[i].jpgname,img);

        ScrollBox2.InsertComponent(panel);
        ScrollBox2.Update;
        ScrollBox2.Invalidate;
      end;
    end;

  //MessageDlg(TMenuItem(Sender).Caption,mtCustom,[mbYes,mbAll,mbCancel], 0);
end;

procedure TForm4.LabelSiteClose(Sender: TObject);
var
  l : TLabel;
  i : integer;
 HTTP: TIdHTTP;
 data: TIdMultiPartFormDataStream;
 Buffer:String;
 SSL:TIdSSLIOHandlerSocketOpenSSL;
begin
  l := Sender as TLabel;
  i := 0;
  data := TIdMultiPartFormDataStream.Create;
  data.AddFormField('csrf_token', Cookie);
  data.AddFormField('siteid', IntToStr((l.Parent as TPanel).Tag));

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
    Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/deletesite.php',data);
  except
    //ShowMessage('Отсутствует связь с сервером' + #10#13);
    Exit;
  end;
  HTTP.Destroy;
  SSL.Destroy;

  while i < OpsSites.Items.Count do
  begin
    if OpsSites.Items[i].Caption = ((l.Parent as TPanel).Components[0] as TLabel).Caption then
      OpsSites.Items.Delete(i)
    else
      Inc(i);
  end;
  i := 0;
  while i < UsersSites.Items.Count do
  begin
    if UsersSites.Items[i].Caption = ((l.Parent as TPanel).Components[0] as TLabel).Caption then
      UsersSites.Items.Delete(i)
    else
      Inc(i);
  end;
  l.Parent.Destroy;
  for i := 0 to ScrollBox3.ComponentCount -1 do
    begin
      (ScrollBox3.Components[i] as TPanel).Top := i * 30 +10;
    end;

end;
procedure TForm4.menu1OnDrawItem(Sender: TObject; ACanvas: TCanvas;
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
    panel.Color := clWhite;
    panel.ShowCaption := false; panel.BevelOuter := bvNone;
    panel.Height := 25;

    labelDomain :=TLabel.Create(nil);
    labelDomain.Parent := panel; labelDomain.AutoSize :=true; //labelName.OnClick := Panel14Click;
    labelDomain.Caption := domain;labelDomain.Left := 4;labelDomain.Top := 4;//labelDomain.Width := 120;
    labelDomain.Font.Color := $00DFA94B; labelDomain.Font.Name := 'Arial'; labelDomain.Font.Height := -13;//labelDomain.Font.Style := [fsBold];

    Item := TMenuItem.Create(OpsSites);
    Item.Caption := domain;
    Item.OnClick := HandleOpsSites;
    Item.OnDrawItem := menu1OnDrawItem;
    OpsSites.OwnerDraw := true;
    OpsSites.Items.Add(Item);
    Item := TMenuItem.Create(UsersSites);
    Item.Caption := domain;
    Item.OnClick := N5Click;
    Item.OnDrawItem := menu1OnDrawItem;
    UsersSites.OwnerDraw := true;
    UsersSites.Items.Add(Item);
    panel.Width := labelDomain.Width+30;

{/    labelClose :=TLabel.Create(nil);
    labelClose.Parent := panel;
    labelClose.Caption := 'x';
    labelClose.Font.Color := $000000FF;
    labelClose.Align := alRight;
    labelClose.Width := 15;
    labelClose.Layout := tlCenter;
    labelClose.OnClick := LabelSiteClose;

    panel.InsertComponent(labelDomain);}

    ScrollBox3.InsertComponent(panel);
    ScrollBox3.Update;
    ScrollBox3.Invalidate;

end;
procedure TForm4.InsertOpToScrollBox(id:integer;name:string;status:string;jpgname:string;sitesdepts:TSitesDepts);
var
panel : TPanel;
labelName : TLabel;
labelStatus : TLabel;
labelDomain : TLabel;
img : TImage;
i,i1,i2 : integer;
opindept,opindomain:boolean;
begin
    i := length(Operators);
    SetLength(Operators, i+1);
    Operators[i].id := id;
    Operators[i].name := name;
    Operators[i].status := status;
    Operators[i].jpgname := jpgname;
    Operators[i].sitesdepts := sitesdepts;
    //Operators[i].department := department;

  opindept := false; opindomain := false;
  for i1 := 0 to length(Operators[i].sitesdepts)-1 do
  begin
  if Operators[i].sitesdepts[i1].domain = Label28.Caption then opindomain := true;
  for i2 := 0 to length(Operators[i].sitesdepts[i1].depts)-1 do
       if (Operators[i].sitesdepts[i1].domain = Label28.Caption) and (Operators[i].sitesdepts[i1].depts[i2].dept = Label35.Caption) then
          opindept := true;
  end;
 //if ((Pos(WideString(#39+Label28.Caption+#39),Operators[i].domain)>0) or (Label28.Caption = 'Всех сайтах'))and ((Pos(WideString(#39+Label35.Caption+#39),Operators[i].department)>0) or (Label35.Caption = 'Все отделы')) then
 if ((opindomain) or (Label28.Caption = 'Всех сайтах'))and ((opindept) or (Label35.Caption = 'Все отделы')) then
 begin

    panel :=TPanel.Create(nil);
    panel.Parent := ScrollBox2;
    panel.Align := alNone;
    panel.Top := Trunc(ScrollBox2.ComponentCount / Trunc(ScrollBox2.ClientWidth / 130)) * 50 + 10;
    panel.Left := (ScrollBox2.ComponentCount - (Trunc(ScrollBox2.ComponentCount / Trunc(ScrollBox2.ClientWidth / 130))*Trunc(ScrollBox2.ClientWidth / 130)))* 130 + 10;
    panel.Tag := id;
 //   panel.OnClick := Panel14Click;
    panel.ParentBackground := false;
    panel.Color := clWhite;
    panel.ShowCaption := false;
    panel.Width := 120; panel.BevelOuter := bvNone;
    panel.Height := 40;

    labelName :=TLabel.Create(nil);
    labelName.Parent := panel;
    labelName.Caption := name;
    labelName.Align := alNone;
    labelName.Left := 38;
    labelName.Top := 2; labelName.Font.Color := $00675551;
    labelName.Font.Name := 'Arial'; labelName.Font.Height := -12;
//    labelName.OnClick := Label24Click;

    labelStatus :=TLabel.Create(nil);
    labelStatus.Parent := panel; //labelName.OnClick := Panel14Click;
    labelStatus.Caption := status;labelStatus.Left := 38;labelStatus.Top := 15;
    if status = 'В сети' then
     labelStatus.Font.Color := $0065BA34
     else labelStatus.Font.Color := $002168EB;
    labelStatus.Font.Name := 'Arial'; labelStatus.Font.Height := -12;labelStatus.Font.Style := [fsBold];

//    labelDomain := TLabel.Create(nil);
//    labelDomain.Parent := panel;
//    labelDomain.Caption := domain;
//    labelDomain.Visible := false;
//    panel.InsertComponent(labelDomain);

    img :=TImage.Create(nil);
    img.Parent := panel;
    img.Align := alNone;
    img.Left := 0;img.Top := 0;img.Width := 32;img.Height := 32;
    if jpgname<>'' then DownloadJPG(jpgname,img);

    ScrollBox2.InsertComponent(panel);
    ScrollBox2.Update;
    ScrollBox2.Invalidate;
 end;

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
      idhttp1.Get('https://nachalosaita.itgroup.kz/img/'+url,str);
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

procedure TForm4.Button2Click(Sender: TObject);
var
Buffer: String;
 HTTP: TIdHTTP;
 data: TIdMultiPartFormDataStream;
 S,s1:String;
 SSL:TIdSSLIOHandlerSocketOpenSSL;
begin
  data := TIdMultiPartFormDataStream.Create;
  data.AddFormField('csrf_token', cookie);
  data.AddFormField('userid', IntToStr(Edit1.Tag));
  data.AddFormField('name', UTF8Encode(Edit1.Text), 'utf-8').ContentTransfer := '8bit';
  data.AddFormField('phone', UTF8Encode(Edit2.Text), 'utf-8').ContentTransfer := '8bit';
  data.AddFormField('email', UTF8Encode(Edit3.Text), 'utf-8').ContentTransfer := '8bit';
  data.AddFormField('comment', UTF8Encode(Memo2.Lines.Text), 'utf-8').ContentTransfer := '8bit';

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
    Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/saveusercomment.php',data);
  except
    ShowMessage('Отсутствует связь с сервером' + #10#13);
    Exit;
  end;
  HTTP.Destroy;
  SSL.Destroy;
end;

procedure TForm4.CallFoo(const S: string; I: Integer;T: string);
var
  Doc: IHTMLDocument2;
  HTMLWindow: IHTMLWindow2;
  JSFn: string;
  s1: string;

begin
  Doc := WebBrowser1.Document as IHTMLDocument2;
  if not Assigned(Doc) then
    Exit;
  HTMLWindow := Doc.parentWindow;
  if not Assigned(HTMLWindow) then
    Exit;

  try

    s1 := StringReplace( S , '"', #39, [rfReplaceAll]);
    //s1:=S;
    JSFn := Format('doupdate("%s",%d,"%s")', [s1, I, T]);

    HTMLWindow.execScript(JSFn, 'JavaScript');
  except
    // handle exception in case JavaScript fails to run
  end;
end;
function getRequestDialogs(JsonString: String): TUsersDialog;
var
  JSonValue: TJSonValue;
  JsonArray,JsonArray2: TJSONArray;
  ArrayElement,ArrayElement2: TJSonValue;
  msgs : WideString;

  FmtStngs: TFormatSettings;
  TimeInfo:_TIME_ZONE_INFORMATION;
  dtime,mcolor:string;
  i:integer;
  otud1: TStartOTUD1;
begin
GetTimeZoneInformation(TimeInfo);
GetLocaleFormatSettings( GetThreadLocale, FmtStngs );
FmtStngs.DateSeparator := '-';
FmtStngs.ShortDateFormat := 'yyyy-mm-dd';
FmtStngs.TimeSeparator := ':';
FmtStngs.LongTimeFormat := 'hh:nn:ss';

  SetLength(Result.users,0);
  JsonValue := TJSonObject.ParseJSONValue(JsonString);
  JsonArray := JsonValue.GetValue<TJSONArray>('requestdialogs');
  //i := 0;
  for ArrayElement in JsonArray do begin
  //if i = 0 then Form4.Memo3.Text := JsonString;
  otud1 := getOTUD(StrToInt(ArrayElement.GetValue<String>('id')));
  //i := i+1;
      //if ArrayElement.GetValue<String>('id') = User then begin
      //for ArrayElement2 in JsonArray2 do begin
        SetLength(Result.users,length(Result.users)+1);
        Result.users[length(Result.users)-1].id := StrToInt(ArrayElement.GetValue<String>('id'));
        Result.users[length(Result.users)-1].newmsgcnt := ArrayElement.GetValue<String>('newmsgcnt');
        Result.users[length(Result.users)-1].name := ArrayElement.GetValue<String>('name');
        Result.users[length(Result.users)-1].phone := ArrayElement.GetValue<String>('phone');
        Result.users[length(Result.users)-1].email := ArrayElement.GetValue<String>('email');
        Result.users[length(Result.users)-1].comment := ArrayElement.GetValue<String>('comment');
        Result.users[length(Result.users)-1].ip := ArrayElement.GetValue<String>('ip');
        Result.users[length(Result.users)-1].urlfrom := ArrayElement.GetValue<String>('refferer');
        Result.users[length(Result.users)-1].urlto := ArrayElement.GetValue<String>('urlsite');
        Result.users[length(Result.users)-1].view := ArrayElement.GetValue<String>('watch');
        Result.users[length(Result.users)-1].onsitetime := ArrayElement.GetValue<String>('onsitetime');
        Result.users[length(Result.users)-1].pageviews := ArrayElement.GetValue<String>('pageviews');
        Result.users[length(Result.users)-1].visits := ArrayElement.GetValue<String>('visits');
        Result.users[length(Result.users)-1].msgtime := ArrayElement.GetValue<String>('lastmsgtime');
//        Result.users[length(Result.users)-1].visittime := ArrayElement.GetValue<String>('lastvisittime');
        JsonArray2 := ArrayElement.GetValue<TJSONArray>('msgs');msgs:='';
        for ArrayElement2 in JsonArray2 do
        begin
          dtime := DateTimeToStr(IncMinute(StrToDateTime(ArrayElement2.GetValue<String>('dtime'),FmtStngs),TimeInfo.Bias*-1),FmtStngs);
          if ArrayElement2.GetValue<String>('toop') = '1' then
            msgs := msgs + '<div class="style9" title="'+dtime+'"><font size="2" color="#A0A0A0" face="Arial">'+dtime+'</font><br>'+ ArrayElement2.GetValue<String>('msg') + '</div>'
            else
          if ArrayElement2.GetValue<String>('toop') = '0' then
            msgs := msgs + '<div class="style8" title="'+dtime+'"><font size="2" color="#F0F0F0" face="Arial">'+dtime+'</font><br>'+ ArrayElement2.GetValue<String>('msg') + '</div>'
            else
            msgs := msgs + '<div class="style10" title="'+dtime+'"><font size="2" color="#555555" face="Arial">'+dtime+'</font><br>'+ ArrayElement2.GetValue<String>('msg') + '</div>';;
        end;
        Result.users[length(Result.users)-1].msgs := msgs;
      //  break;
      //end;
  end;
  //Result := Result + JsonValue.GetValue<String>('cookies');
end;
function getDialogs(JsonString: String): TUsersDialog;
var
  JSonValue: TJSonValue;
  JsonArray,JsonArray2: TJSONArray;
  ArrayElement,ArrayElement2: TJSonValue;
  msgs : WideString;

  FmtStngs: TFormatSettings;
  TimeInfo:_TIME_ZONE_INFORMATION;
  dtime,mcolor:string;
begin
  GetTimeZoneInformation(TimeInfo);
  GetLocaleFormatSettings( GetThreadLocale, FmtStngs );
  FmtStngs.DateSeparator := '-';
  FmtStngs.ShortDateFormat := 'yyyy-mm-dd';
  FmtStngs.TimeSeparator := ':';
  FmtStngs.LongTimeFormat := 'hh:nn:ss';

  SetLength(Result.users,0);
  JsonValue := TJSonObject.ParseJSONValue(JsonString);
  JsonArray := JsonValue.GetValue<TJSONArray>('dialogs');
  for ArrayElement in JsonArray do begin
      //if ArrayElement.GetValue<String>('id') = User then begin
      //for ArrayElement2 in JsonArray2 do begin
        SetLength(Result.users,length(Result.users)+1);
        Result.users[length(Result.users)-1].id := StrToInt(ArrayElement.GetValue<String>('id'));
        Result.users[length(Result.users)-1].newmsgcnt := ArrayElement.GetValue<String>('newmsgcnt');
        Result.users[length(Result.users)-1].name := ArrayElement.GetValue<String>('name');
        Result.users[length(Result.users)-1].phone := ArrayElement.GetValue<String>('phone');
        Result.users[length(Result.users)-1].email := ArrayElement.GetValue<String>('email');
        Result.users[length(Result.users)-1].comment := ArrayElement.GetValue<String>('comment');
        Result.users[length(Result.users)-1].ip := ArrayElement.GetValue<String>('ip');
        Result.users[length(Result.users)-1].urlfrom := ArrayElement.GetValue<String>('refferer');
        Result.users[length(Result.users)-1].urlto := ArrayElement.GetValue<String>('urlsite');
        Result.users[length(Result.users)-1].view := ArrayElement.GetValue<String>('watch');
        Result.users[length(Result.users)-1].onsitetime := ArrayElement.GetValue<String>('onsitetime');
        Result.users[length(Result.users)-1].pageviews := ArrayElement.GetValue<String>('pageviews');
        Result.users[length(Result.users)-1].visits := ArrayElement.GetValue<String>('visits');
        Result.users[length(Result.users)-1].msgtime := ArrayElement.GetValue<String>('lastmsgtime');
//        Result.users[length(Result.users)-1].visittime := ArrayElement.GetValue<String>('lastvisittime');
        JsonArray2 := ArrayElement.GetValue<TJSONArray>('msgs');msgs:='';
        for ArrayElement2 in JsonArray2 do
        begin
          dtime := DateTimeToStr(IncMinute(StrToDateTime(ArrayElement2.GetValue<String>('dtime'),FmtStngs),TimeInfo.Bias*-1),FmtStngs);
          msgs := msgs + '<div class="style9" title="'+dtime+'"><font size="2" color="#A0A0A0" face="Arial">'+dtime+'</font><br>' + ArrayElement2.GetValue<String>('msg') + '</div>';
        end;
        Result.users[length(Result.users)-1].msgs := msgs;
      //  break;
      //end;
  end;
  //Result := Result + JsonValue.GetValue<String>('cookies');
end;
function getUsers(JsonString: String): TUsersSB;
var
  JSonValue: TJSonValue;
  JsonArray,JsonArray2: TJSONArray;
  ArrayElement: TJSonValue;
  FoundValue: TJSonValue;
begin
  SetLength(Result,0);
  JsonValue := TJSonObject.ParseJSONValue(JsonString);
  JsonArray := JsonValue.GetValue<TJSONArray>('users');
  for ArrayElement in JsonArray do begin
      //if ArrayElement.GetValue<String>('id') = User then begin
      //for ArrayElement2 in JsonArray2 do begin
        SetLength(Result,length(Result)+1);
        Result[length(Result)-1].id := StrToInt(ArrayElement.GetValue<String>('id'));
        Result[length(Result)-1].name := ArrayElement.GetValue<String>('name');
        Result[length(Result)-1].phone := ArrayElement.GetValue<String>('phone');
        Result[length(Result)-1].email := ArrayElement.GetValue<String>('email');
        Result[length(Result)-1].comment := ArrayElement.GetValue<String>('comment');
        Result[length(Result)-1].ip := ArrayElement.GetValue<String>('ip');
        Result[length(Result)-1].urlfrom := ArrayElement.GetValue<String>('refferer');
        Result[length(Result)-1].urlto := ArrayElement.GetValue<String>('urlsite');
        Result[length(Result)-1].view := ArrayElement.GetValue<String>('watch');
        Result[length(Result)-1].onsitetime := ArrayElement.GetValue<String>('onsitetime');
        Result[length(Result)-1].pageviews := ArrayElement.GetValue<String>('pageviews');
        Result[length(Result)-1].visits := ArrayElement.GetValue<String>('visits');
        Result[length(Result)-1].dialogscnt := ArrayElement.GetValue<String>('dialogscnt');
        Result[length(Result)-1].opname := ArrayElement.GetValue<String>('opname');
        Result[length(Result)-1].opjpg := ArrayElement.GetValue<String>('opjpg');
        Result[length(Result)-1].msgtime := ArrayElement.GetValue<String>('lastmsgtime');
        Result[length(Result)-1].visittime := ArrayElement.GetValue<String>('lastvisittime');
      //  break;
      //end;
  end;
  //Result := Result + JsonValue.GetValue<String>('cookies');
end;
function getOperators(JsonString: String): TOperators;
var
  JSonValue: TJSonValue;
  JsonArray,JsonArray2,JsonArray3: TJSONArray;
  ArrayElement,ArrayElement2,ArrayElement3: TJSonValue;
  FoundValue: TJSonValue;
  i,i1:integer;
begin
  SetLength(Result,0);
  JsonValue := TJSonObject.ParseJSONValue(JsonString);
  JsonArray := JsonValue.GetValue<TJSONArray>('ops');
  for ArrayElement in JsonArray do begin
        SetLength(Result,length(Result)+1);
        Result[length(Result)-1].id := StrToInt(ArrayElement.GetValue<String>('id'));
        Result[length(Result)-1].name := ArrayElement.GetValue<String>('name');
        Result[length(Result)-1].jpgname := ArrayElement.GetValue<String>('jpgname');
        Result[length(Result)-1].status := ArrayElement.GetValue<String>('status');
        //Result[length(Result)-1].domain := ArrayElement.GetValue<String>('domain');
        //Result[length(Result)-1].department := ArrayElement.GetValue<String>('department');
        JsonArray2 := ArrayElement.GetValue<TJSONArray>('sitesdepts');
        SetLength(Result[length(Result)-1].sitesdepts,0);i:=0;
        for ArrayElement2 in JsonArray2 do
        begin
          SetLength(Result[length(Result)-1].sitesdepts,length(Result[length(Result)-1].sitesdepts)+1);
          Result[length(Result)-1].sitesdepts[i].domain := ArrayElement2.GetValue<String>('domain');
{/          SetLength(Result[length(Result)-1].sitesdepts[i].depts,0);i1:=0;
          JsonArray3 := ArrayElement2.GetValue<TJSONArray>('depts');
          for ArrayElement3 in JsonArray3 do
          begin
              SetLength(Result[length(Result)-1].sitesdepts[i].depts,length(Result[length(Result)-1].sitesdepts[i].depts)+1);
              Result[length(Result)-1].sitesdepts[i].depts[i1].dept := ArrayElement3.GetValue<String>('dept');
              i1:=i1+1;
          end;
          }
          i:=i+1;
        end;
  end;
end;
function getUserTyping(JsonString: String): TUserTyping;
var
  JSonValue: TJSonValue;
  JsonArray,JsonArray2: TJSONArray;
  ArrayElement,ArrayElement2: TJSonValue;
begin
  JsonValue := TJSonObject.ParseJSONValue(JsonString);
  JsonArray := JsonValue.GetValue<TJSONArray>('usertyping');
  for ArrayElement in JsonArray do begin
        Result.watch := ArrayElement.GetValue<String>('watch');
        Result.onsitetime := ArrayElement.GetValue<String>('onsitetime');
        Result.pageviews := ArrayElement.GetValue<String>('pageviews');
        Result.visits := '';//ArrayElement.GetValue<String>('visits');
        Result.usrtyping := ArrayElement.GetValue<String>('usrtyping');
  end;
end;
procedure THTTPThread1.Execute;
var
 SSL:TIdSSLIOHandlerSocketOpenSSL;
begin
  GlobalHTTPok1 := false;
  SSL:=TIdSSLIOHandlerSocketOpenSSL.Create(Application);
  SSL.ReadTimeOut:=10000;
  ///sslvSSLv2, sslvSSLv23, sslvSSLv3, sslvTLSv1,sslvTLSv1.sslvTLSv1_1,sslvTLSv1_2
  SSL.SSLOptions.Method:=sslvSSLv23;
  SSL.SSLOptions.Mode:=sslmUnassigned;
  GlobalHTTP1.IOHandler:=SSL;
 try
  GlobalBuffer1 := GlobalHTTP1.Post(GlobalUrl1,Globaldata1);
 except
  GlobalHTTPok1 := true;
  Exit;
 end;
 SSL.Free;
 GlobalHTTPok1 := true;
 FreeOnTerminate := True;
 Destroy;
end;
procedure THTTPThread.Execute;
var
 SSL:TIdSSLIOHandlerSocketOpenSSL;
begin
  GlobalHTTPok := false;
  SSL:=TIdSSLIOHandlerSocketOpenSSL.Create(Application);
  SSL.ReadTimeOut:=10000;
  ///sslvSSLv2, sslvSSLv23, sslvSSLv3, sslvTLSv1,sslvTLSv1.sslvTLSv1_1,sslvTLSv1_2
  SSL.SSLOptions.Method:=sslvSSLv23;
  SSL.SSLOptions.Mode:=sslmUnassigned;
  GlobalHTTP.IOHandler:=SSL;
 try
  GlobalBuffer := GlobalHTTP.Post(GlobalUrl,Globaldata);
 except
  GlobalHTTPok := true;
  Exit;
 end;
 SSL.Free;
 GlobalHTTPok := true;
 FreeOnTerminate := True;
 Destroy;
end;
procedure Updates(hWnd1: HWND; uMsg: UINT; idEvent: UINT_PTR; dwTime: DWORD); stdcall;
var
 Buffer: String;
 uname,uphone,uemail,ucomment: String;
 HTTP: TIdHTTP;
 data: TIdMultiPartFormDataStream;
 S,s1:String;
 SSL:TIdSSLIOHandlerSocketOpenSSL;
// Ops1 : TOperators;
 i,i1,i2 : integer;
 Users1 : TUsersSB;
 Dialogs1,RequestDialogs1 : TUsersDialog;
 innerHTMLtmp : WideString;
 document :IHTMLDocument2;
 UserTyping:TUserTyping;
 AMsg: TMsg;

begin
  if NeedExit2 = true then begin KillTimer(Application.Handle, idEvent); Exit; end;

  data := TIdMultiPartFormDataStream.Create;
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

Buffer := '';
 SetLength(Ops1,0);
 if NeedExit then begin
 KillTimer(Form4.Handle, idEvent);
  data.Clear;
  HTTP.Request.CustomHeaders.text := 'Cookie: MibewSessionID='+MibewSessionID+'; ';
//  try
//    Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/logout',data);
//  except
//    ShowMessage('Отсутствует связь с сервером2' + #10#13 + Buffer);
//    Exit;
//  end;
    GlobalUrl := 'https://test3.console.vipsite.kz/api-chat/logout';

    GlobalHTTPok := false;GlobalHTTP := HTTP;Globaldata := data;
    httpThread:=THTTPThread.Create(false);
    while GlobalHTTPok = false do
    begin
     Sleep(10);application.ProcessMessages;
     if GetMessage(AMsg, Form4.Handle, 0, 0)
    then begin
        TranslateMessage(AMsg);
        DispatchMessage(AMsg);
    end;
    end;
//    httpThread.Destroy;
    Buffer := GlobalBuffer;

 mustexit:=false;
 Shell_NotifyIcon(NIM_DELETE, @Form4.TrayIconData);
 TerminateProcess(OpenProcess(PROCESS_TERMINATE,False,GetCurrentProcessId),0);
// Form4.Close();
//Wnd1 := GetActiveWindow;
 // if IsWindow(Wnd1) then
   // PostMessage(GetActiveWindow, WM_CLOSE, 0, 0);
// Application.Terminate;
 Exit;
 end;


 if not UpdatesFlag then begin KillTimer(Application.Handle, idEvent);  end;
 QueueUpdates := QueueUpdates+1;
 if CursorPos = Mouse.CursorPos then
 begin
   Inc(OfflineCounter);
   if OfflineCounter > 180 then
   begin
     if Form4.Label21.Caption = 'В сети' then
     begin
       Form4.Label21.Caption := 'Отошёл';
       Form4.Label21.Font.Color := $002D6FEB;
       data.Destroy;
       data := TIdMultiPartFormDataStream.Create;
       data.AddFormField('csrf_token', Cookie);
       HTTP.Request.CustomHeaders.text := 'Cookie: MibewSessionID='+MibewSessionID+'; ';
//       data.AddFormField('status', UTF8Encode('Отошёл'), 'utf-8').ContentTransfer := '8bit';
//       try
//        Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/keep-away',data);
//       except
//        //ShowMessage('Отсутствует связь с сервером' + #10#13);
//        Exit;
//       end;
        GlobalUrl := 'https://test3.console.vipsite.kz/api-chat/keep-away';

        GlobalHTTPok := false;GlobalHTTP := HTTP;Globaldata := data;
        httpThread:=THTTPThread.Create(false);
        while GlobalHTTPok = false do
        begin
         Sleep(10);application.ProcessMessages;
         if GetMessage(AMsg, Form4.Handle, 0, 0)
        then begin
            TranslateMessage(AMsg);
            DispatchMessage(AMsg);
        end;
        end;
//        httpThread.Destroy;
        Buffer := GlobalBuffer;

     end;
   end;
 end
 else
 begin
   OfflineCounter := 0;
   CursorPos := Mouse.CursorPos;
     if Form4.Label21.Caption = 'Отошёл' then
     begin
       Form4.Label21.Caption := 'В сети';
       Form4.Label21.Font.Color := $006CBD3C;
       data.Destroy;
       data := TIdMultiPartFormDataStream.Create;
       data.AddFormField('csrf_token', Cookie);
       HTTP.Request.CustomHeaders.text := 'Cookie: MibewSessionID='+MibewSessionID+'; ';
////       data.AddFormField('status', UTF8Encode('В сети'), 'utf-8').ContentTransfer := '8bit';
//       try
//        Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/keep-online',data);
//       except
//        //ShowMessage('Отсутствует связь с сервером' + #10#13);
//        Exit;
//       end;
        GlobalUrl := 'https://test3.console.vipsite.kz/api-chat/keep-online';

        GlobalHTTPok := false;GlobalHTTP := HTTP;Globaldata := data;
        httpThread:=THTTPThread.Create(false);
        while GlobalHTTPok = false do
        begin
         Sleep(10);application.ProcessMessages;
//         if GetMessage(AMsg, Form4.Handle, 0, 0)
//        then begin
//            TranslateMessage(AMsg);
//            DispatchMessage(AMsg);
//        end;
        end;
//        httpThread.Destroy;
        Buffer := GlobalBuffer;
     end;
 end;
 if GlobalHTTPok = false then begin
   //HTTP.Free;
   SSL.Free;
   Exit;
 end;
 data.Clear;// := TIdMultiPartFormDataStream.Create;
 data.AddFormField('csrf_token', Cookie);
 HTTP.Request.CustomHeaders.text := 'Cookie: MibewSessionID='+MibewSessionID+'; ';
//  try
//   if OfflineCounter > 180 then
//    Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/keep-away',data)
//    else
//    Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/keep-online',data);
//
//  except
//    //ShowMessage('Отсутствует связь с сервером' + #10#13);
//    Exit;
//  end;
if KeepOnlineInterval > 35 then
begin
KeepOnlineInterval :=0;
if OfflineCounter > 180 then
GlobalUrl := 'https://test3.console.vipsite.kz/api-chat/keep-away'
else
GlobalUrl := 'https://test3.console.vipsite.kz/api-chat/keep-online';

GlobalHTTPok := false;GlobalHTTP := HTTP;Globaldata := data;
httpThread:=THTTPThread.Create(false);
while GlobalHTTPok = false do
begin
 Sleep(10);application.ProcessMessages;
// if GetMessage(AMsg, Form4.Handle, 0, 0)
//then begin
//    TranslateMessage(AMsg);
//    DispatchMessage(AMsg);
//end;
end;
//httpThread.Destroy;
Buffer := GlobalBuffer;
end
else KeepOnlineInterval := KeepOnlineInterval+1;



 data.Clear;
 data.AddFormField('csrf_token', Cookie);
 s := '[';
     for i1 := 0 to Length(Dialogs.users)-1 do
     begin
             for i2 := 0 to Form4.ScrollBox1.ComponentCount -1 do
              if ((Form4.ScrollBox1.Components[i2] as TPanel).Tag = Dialogs.users[i1].id) then
              begin
                s := s + '{"userid":"' + IntToStr(Dialogs.users[i1].id) + '","lastmsgtime":"'+Dialogs.users[i1].msgtime + '"},';
              end;
     end;
 s := Copy(s,1,Length(s)-1) + ']';
 data.AddFormField('usersmsgtime', s);
 HTTP.Request.CustomHeaders.text := 'Cookie: MibewSessionID='+MibewSessionID+'; ';

//
// try
//  Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/operator/update',data);
// except
//  //KillTimer(Form4.Handle, idEvent);
//  //ShowMessage('Отсутствует связь с сервером' + #10#13);
//  Exit;
// end;


GlobalHTTPok := false;GlobalHTTP := HTTP;Globaldata := data;
GlobalUrl := 'https://test3.console.vipsite.kz/api-chat/operator/update';
httpThread:=THTTPThread.Create(false);
while GlobalHTTPok = false do
begin
 Sleep(10);application.ProcessMessages;
// if GetMessage(AMsg, Form4.Handle, 0, 0)
// then begin
//    TranslateMessage(AMsg);
//    DispatchMessage(AMsg);
// end;
end;
//httpThread.Destroy;
Buffer := GlobalBuffer;
//Form4.Memo3.Text := Buffer;



 //SetLength(Ops1,0);
 Form4.ScrollBox2.DestroyComponents;SetLength(Operators,0);
 Ops1 := getOperators(Buffer);
 for i := 0 to Length(Ops1)-1 do
 begin
    Form4.InsertOpToScrollBox(Ops1[i].id,Ops1[i].name,Ops1[i].status,Ops1[i].jpgname,Ops1[i].sitesdepts);
 end;

 //Form4.ScrollBox4.DestroyComponents; SetLength(Users,0);
 Users1 := getUsers(Buffer);
 for i := 0 to Length(Users1)-1 do
 begin
    Form4.InsertUserToScrollBox(Users1[i]);
 end;
  for I := 0 to Form4.ScrollBox4.ComponentCount-1 do
  begin
    i2 := -1;
    for i1 := 0 to Length(Users1)-1 do
      if (Form4.ScrollBox4.Components[I] as TPanel).Tag = Users1[i1].id then i2:=Users1[i1].id;
    if i2 = -1 then
    begin
       for i2 := 0 to Length(Users)-1 do
         if Users[i2].id = (Form4.ScrollBox4.Components[I] as TPanel).Tag then
         begin
           Form4.DeleteUser(i2);
           (Form4.ScrollBox4.Components[I] as TPanel).Destroy;
         end;
    end;
  end;


 Dialogs1 := getDialogs(Buffer);
 for i := 0 to Length(Dialogs1.users)-1 do
 begin
     for i1 := 0 to Length(Dialogs.users)-1 do
     begin
        if Dialogs1.users[i].id = Dialogs.users[i1].id then
        if Length(Dialogs1.users[i].msgs)>0 then
        begin
             innerHTMLtmp := Dialogs.users[i1].innerHTML;
             Dialogs.users[i1] := Dialogs1.users[i];
             Dialogs.users[i1].innerHTML := Copy(innerHTMLtmp,1,Length(innerHTMLtmp)-12) + Dialogs1.users[i].msgs + '</div></div>';
             for i2 := 0 to Form4.ScrollBox1.ComponentCount -1 do
              if ((Form4.ScrollBox1.Components[i2] as TPanel).Tag = Dialogs1.users[i].id) and ((Form4.ScrollBox1.Components[i2] as TPanel).Color = clWhite) then
              begin
                document := Form4.webBrowser1.Document as IHTMLDocument2;
                document.body.innerHTML := Copy(document.body.innerHTML,1,Length(document.body.innerHTML)-12) + Dialogs1.users[i].msgs + '</div></div>';
                Form4.WebBrowser1.OleObject.Document.ParentWindow.ScrollBy(0, 100000);
                Form4.Edit1.Text := Dialogs1.users[i].name;
                Form4.Edit1.Tag := Dialogs.users[i].id;
                Form4.Edit2.Text := Dialogs1.users[i].phone;
                Form4.Edit3.Text := Dialogs1.users[i].email;
                Form4.Memo2.Text := Dialogs1.users[i].comment;
                Form4.Label7.Caption := Dialogs1.users[i].ip;
                Form4.Label9.Caption := Dialogs1.users[i].urlfrom;
                Form4.Label23.Caption := Dialogs1.users[i].urlto;
                Form4.Label11.Caption := Dialogs1.users[i].view;
                Form4.Label13.Caption := Dialogs1.users[i].onsitetime;
                Form4.Label15.Caption := Dialogs1.users[i].pageviews;
                Form4.Label17.Caption := Dialogs1.users[i].visits;
              end;
             for i2 := 0 to Form4.ScrollBox1.ComponentCount -1 do
              if ((Form4.ScrollBox1.Components[i2] as TPanel).Tag = Dialogs1.users[i].id) then
              begin
                 ((Form4.ScrollBox1.Components[i2] as TPanel).Components[1] as TLabel).Caption := Dialogs1.users[i].name;
                 ((Form4.ScrollBox1.Components[i2] as TPanel).Components[2] as TLabel).Caption := Dialogs1.users[i].email;
                 ((Form4.ScrollBox1.Components[i2] as TPanel).Components[0] as TLabel).Caption := Dialogs1.users[i].newmsgcnt;
                 if Dialogs1.users[i].newmsgcnt <> '' then Form6.FormShow('Есть новые сообщения',Dialogs1.users[i].name,Dialogs1.users[i].urlto);

              end;

        end;

     end;
 end;


 RequestDialogs1 := getRequestDialogs(Buffer);
 for i := 0 to Length(RequestDialogs1.users)-1 do
 begin
  uname := RequestDialogs1.users[i].name;
  uphone := RequestDialogs1.users[i].phone;
  uemail := RequestDialogs1.users[i].email;
  ucomment := RequestDialogs1.users[i].comment;
  if uname = '' then uname := RequestDialogs1.users[i].ip;
  if RequestDialogs1.users[i].phone = '' then uphone := 'Телефон';
  if RequestDialogs1.users[i].email = '' then uemail := 'Email';
  if RequestDialogs1.users[i].comment = '' then ucomment := 'Добавить комментарий';


  Form4.InsertUserToDialogs(RequestDialogs1.users[i].id,RequestDialogs1.users[i].newmsgcnt,uname,uphone,uemail,
      ucomment,RequestDialogs1.users[i].ip,RequestDialogs1.users[i].urlfrom,RequestDialogs1.users[i].urlto,RequestDialogs1.users[i].view,
      RequestDialogs1.users[i].onsitetime,RequestDialogs1.users[i].pageviews,RequestDialogs1.users[i].visits,'Здравствуйте, чем я могу вам помочь?','<div class="style7" id="chatform"><div id="mainform" style="transform: translateY(0px);" height="100%">' + RequestDialogs1.users[i].msgs + '</div></div>',RequestDialogs1.users[i].msgtime,RequestDialogs1.users[i].visittime);



 end;

 if Form4.Memo1.Lines.Text <> LastChatMessage then
 begin
   if LastChatStatusMessage <> 1 then
   begin
      data.Destroy;
      data := TIdMultiPartFormDataStream.Create;
      data.AddFormField('csrf_token', Cookie);
      data.AddFormField('userid', IntToStr(LastChatUserId));
      data.AddFormField('optyping', '1');
      HTTP.Request.CustomHeaders.text := 'Cookie: MibewSessionID='+MibewSessionID+'; ';
      GlobalHTTPok := false;GlobalHTTP := HTTP;Globaldata := data;
      GlobalUrl := 'https://test3.console.vipsite.kz/api-chat/operator-typing';
      httpThread:=THTTPThread.Create(false);
      while GlobalHTTPok = false do begin Sleep(10);application.ProcessMessages;end;
      LastChatStatusMessage := 1;
      //Form4.PreProcessMessage()
   end;
 end
 else
 begin
   if LastChatStatusMessage <> 2 then
   begin
      data.Destroy;
      data := TIdMultiPartFormDataStream.Create;
      data.AddFormField('csrf_token', Cookie);
      data.AddFormField('userid', IntToStr(LastChatUserId));
      data.AddFormField('optyping', '0');
      HTTP.Request.CustomHeaders.text := 'Cookie: MibewSessionID='+MibewSessionID+'; ';
//      try
//      Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/operator-typing',data);
//      except
//      Exit;
//      end;
      GlobalHTTPok := false;GlobalHTTP := HTTP;Globaldata := data;
      GlobalUrl := 'https://test3.console.vipsite.kz/api-chat/operator-typing';
      httpThread:=THTTPThread.Create(false);
      while GlobalHTTPok = false do begin Sleep(10);application.ProcessMessages;end;
//      httpThread.Destroy;
      LastChatStatusMessage := 2;
   end;
 end;
 LastChatMessage := Form4.Memo1.Lines.Text;
 LastChatUserId := Form4.Edit1.Tag;
//  Form4.InsertUserToDialogs(3,'8','Андрей','+380988988692','andrey@mail.ru',
//      'Добавить комментарий','192.168.100.101','www.google.com','nachalosaita.itgroup.kz3','Программы',
//      '1 час 2 мин.','12','3','Здравствуйте, чем я могу вам помочь?','<div class="style7" id="chatform"><div id="mainform" style="transform: translateY(0px);" height="100%"></div></div>');
  for i2 := 0 to Form4.ScrollBox1.ComponentCount -1 do
  if ((Form4.ScrollBox1.Components[i2] as TPanel).Tag = Form4.Edit1.Tag) and ((Form4.ScrollBox1.Components[i2] as TPanel).Color = clWhite) then
  begin
      data.Destroy;
      data := TIdMultiPartFormDataStream.Create;
      data.AddFormField('csrf_token', Cookie);
      data.AddFormField('userid', IntToStr(Form4.Edit1.Tag));
      HTTP.Request.CustomHeaders.text := 'Cookie: MibewSessionID='+MibewSessionID+'; ';
//      try
//      Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/user/status',data);
//      except
//      Exit;
//      end;
      GlobalHTTPok := false;GlobalHTTP := HTTP;Globaldata := data;
      GlobalUrl := 'https://test3.console.vipsite.kz/api-chat/user/status';
      httpThread:=THTTPThread.Create(false);
      while GlobalHTTPok = false do begin Sleep(10);application.ProcessMessages;end;
//      httpThread.Destroy;
      Buffer := GlobalBuffer;

      UserTyping := getUserTyping(Buffer);
      Form4.Label11.Caption := UserTyping.watch;
      Form4.Label13.Caption := UserTyping.onsitetime;
      Form4.Label15.Caption := UserTyping.pageviews;
      Form4.Label17.Caption := UserTyping.visits;
      //Form4.Memo1.Lines.Add(UserTyping.usrtyping);
      if UserTyping.usrtyping = '1' then Form4.Label33.Caption := 'Пользователь набирает сообщение...'
      else Form4.Label33.Caption := '';
  end;

  HTTP.Destroy;
  SSL.Destroy;
end;
procedure TForm4.DeleteUser( const pos:integer);
var
   lg, j : integer;
begin
   lg := length(Users);
   if pos > lg-1 then
     exit
   else if pos = lg-1 then begin
           Setlength(Users, lg -1);
           exit;
        end;
   for j := pos to lg-2 do
     Users[j] := Users[j+1];
   SetLength(Users, lg-1);
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
procedure Proc(hWnd: HWND; uMsg: UINT; idEvent: UINT_PTR; dwTime: DWORD); stdcall;
var
Item : TMenuItem;
UserSB : TUserSB;
Buffer: String;
 HTTP: TIdHTTP;
 data: TIdMultiPartFormDataStream;
 S,s1:String;
 SSL:TIdSSLIOHandlerSocketOpenSSL;
 ini: TRegIniFile;
// cookie: string;
 logedin,login,password: String;
 i:integer;
  JSonValue: TJSonValue;
begin
 {/ Form4.InsertUserToDialogs(1,'7','Дмитрий','+380988988692','dima@mail.ru',
      'Добавить комментарий','192.168.100.101','www.google.com','nachalosaita.itgroup.kz','Главная страница',
      '1 час 2 мин.','12','3','Здравствуйте, чем я могу вам помочь?','<div class="style7" id="chatform"><div id="mainform" style="transform: translateY(0px);" height="100%"></div></div>','');
  Form4.InsertUserToDialogs(2,'9','Денис','+380988988692','denis@mail.ru',
      'Добавить комментарий','192.168.100.101','www.google.com','nachalosaita.itgroup.kz','Новости',
      '1 час 2 мин.','12','3','Здравствуйте, чем я могу вам помочь?','<div class="style7" id="chatform"><div id="mainform" style="transform: translateY(0px);" height="100%"></div></div>','');
  Form4.InsertUserToDialogs(3,'','Андрей','+380988988692','andrey@mail.ru',
      'Добавить комментарий','192.168.100.101','www.google.com','nachalosaita.itgroup.kz','Ноунтбук',
      '1 час 2 мин.','12','3','Здравствуйте, чем я могу вам помочь?','<div class="style7" id="chatform"><div id="mainform" style="transform: translateY(0px);" height="100%"></div></div>','');
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
  Form4.UsersSites.Items.Clear;
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

  Item := TMenuItem.Create(Form4.UsersSites);
  Item.Caption := '-';
  Item.OnClick := Form4.N5Click;
  Form4.UsersSites.Items.Add(Item);
  Item := TMenuItem.Create(Form4.UsersSites);
  Item.Caption := 'Все сайты';
  Item.OnClick := Form4.N5Click;
  Form4.UsersSites.Items.Add(Item);


  UserSB.id := 7;
  UserSB.name := 'Иннокентий';
  UserSB.phone := 'Добавить телефон';
  UserSB.email := 'innokentiy@mail.ru';
  UserSB.comment := 'Добавить комментарий';
  UserSB.ip := '192.168.101.12';
  UserSB.urlfrom := 'www.google.com';
  UserSB.urlto := 'nachalosaita.itgroup.kz';
  UserSB.view := 'Главная страница';
  UserSB.onsitetime := '1 час 15 мин.';
  UserSB.pageviews := '2';
  UserSB.visits := '25';
  UserSB.dialogscnt := '111';
  UserSB.opname := 'Алуа';
  UserSB.opjpg := 'alex.jpg';
  Form4.InsertUserToScrollBox(UserSB);
  UserSB.id := 8;
  UserSB.name := '';
  UserSB.phone := 'Добавить телефон';
  UserSB.email := 'innokentiy@mail.ru';
  UserSB.comment := 'Добавить комментарий';
  UserSB.ip := '192.168.101.11';
  UserSB.urlfrom := 'www.google.com';
  UserSB.urlto := 'nachalosaita.itgroup.kz';
  UserSB.view := 'О компании';
  UserSB.onsitetime := '1 час 5 мин.';
  UserSB.pageviews := '1';
  UserSB.visits := '5';
  UserSB.dialogscnt := '0';
  UserSB.opname := '';
  UserSB.opjpg := '';
  Form4.InsertUserToScrollBox(UserSB);
  UserSB.id := 9;
  UserSB.name := 'Татьяна';
  UserSB.phone := 'Добавить телефон';
  UserSB.email := 'innokentiy@mail.ru';
  UserSB.comment := 'Добавить комментарий';
  UserSB.ip := '192.168.101.13';
  UserSB.urlfrom := 'www.google.com';
  UserSB.urlto := 'nachalosaita.itgroup.kz';
  UserSB.view := 'Продвижение сайта';
  UserSB.onsitetime := '1 час 35 мин.';
  UserSB.pageviews := '11';
  UserSB.visits := '15';
  UserSB.dialogscnt := '1';
  UserSB.opname := '';
  UserSB.opjpg := '';
  Form4.InsertUserToScrollBox(UserSB);
  }

  KillTimer(Application.Handle, idEvent);
  //Form6.FormShow('авфыфав','авфыфав','авфыфав');
   cookie := '0';
   ini := TRegIniFile.Create('Software\Nachalosaita');
   try
     cookie := ini.ReadString('cookie', 'cookie', '0');
     login := ini.ReadString('cookie', 'login', '0');
     password := ini.ReadString('cookie', 'password', '0');
     logedin := ini.ReadString('cookie', 'logedin', 'false');
   finally
     ini.Free;
   end;
  if(login='0') AND (password='0')then
  begin
    Form4.Hide;
    Form8.Show;
    HTTP.Destroy;
    SSL.Destroy;
    Exit;
  end;
  data := TIdMultiPartFormDataStream.Create;
  data.AddFormField('csrf_token', cookie);

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
  //HTTP.Request.CustomHeaders.text := 'Cookie: MibewSessionID='+MibewSessionID+'; ';
  try
    Buffer := HTTP.Get('https://test3.console.vipsite.kz/api-chat/get-csrf-token');
  except
    ShowMessage('Отсутствует связь с сервером' + #10#13);
    Exit;
  end;



  MibewSessionID := LoadCookies(HTTP.Response.RawHeaders.GetText);
  data.Clear;
  data.AddFormField('login', login);
  data.AddFormField('password', password);
  Cookie := getJSONItem(Buffer,'csrf_token');
  data.AddFormField('csrf_token', Cookie);
  HTTP.Request.CustomHeaders.text := 'Cookie: MibewSessionID='+MibewSessionID+'; ';

  Buffer :='';
  try
    Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/login',data);
  except
    ShowMessage('Отсутствует связь с сервером4' + #10#13);
    Exit;
  end;
//      GlobalHTTPok := false;GlobalHTTP := HTTP;Globaldata := data;
//      GlobalUrl := 'https://test3.console.vipsite.kz/api-chat/login';
//      httpThread:=THTTPThread.Create(false);
//      while GlobalHTTPok = false do begin Sleep(10);application.ProcessMessages;end;
//      httpThread.Destroy;
//      Buffer:=GlobalBuffer;

 Form4.Memo3.Text := Buffer;
    JsonValue := TJSonObject.ParseJSONValue(Buffer);
  if JsonValue.FindValue('code') = nil then
begin
  if (Buffer<>'') then
  begin

    OperatorID := getJSONItem(Buffer,'id');
    if getJSONItem(Buffer,'jpgname')<>'' then Form4.DownloadJPG(getJSONItem(Buffer,'jpgname'),Form4.Image8);
    Form4.Label20.Caption := getJSONItem(Buffer,'name');

    Form4.Departments.Items.Clear;
    Form4.OpsSites.Items.Clear;
    Form4.UsersSites.Items.Clear;
    Form4.ScrollBox3.DestroyComponents;
    Sites := getSites(Buffer);
    for i := 0 to Length(Sites)-1 do
    Form4.InsertSiteToScrollBox(StrToInt(Sites[i].id) ,Sites[i].site );

    Item := TMenuItem.Create(Form4.Departments);
    Item.Caption := '-';
    Item.OnClick := Form4.HandleDepartments;
    Item.OnDrawItem := Form4.menu1OnDrawItem;
    Form4.Departments.OwnerDraw := true;
    Form4.Departments.Items.Add(Item);
    Item := TMenuItem.Create(Form4.Departments);
    Item.Caption := 'Все отделы';
    Item.OnClick := Form4.HandleDepartments;
    Item.OnDrawItem := Form4.menu1OnDrawItem;
    Form4.Departments.OwnerDraw := true;
    Form4.Departments.Items.Add(Item);

    Item := TMenuItem.Create(Form4.OpsSites);
    Item.Caption := '-';
    Item.OnClick := Form4.HandleOpsSites;
    Item.OnDrawItem := Form4.menu1OnDrawItem;
    Form4.OpsSites.OwnerDraw := true;
    Form4.OpsSites.Items.Add(Item);
    Item := TMenuItem.Create(Form4.OpsSites);
    Item.Caption := 'Всех сайтах';
    Item.OnClick := Form4.HandleOpsSites;
    Item.OnDrawItem := Form4.menu1OnDrawItem;
    Form4.OpsSites.OwnerDraw := true;
    Form4.OpsSites.Items.Add(Item);

    Item := TMenuItem.Create(Form4.UsersSites);
    Item.Caption := '-';
    Item.OnClick := Form4.N5Click;
    Item.OnDrawItem := Form4.menu1OnDrawItem;
    Form4.UsersSites.OwnerDraw := true;
    Form4.UsersSites.Items.Add(Item);
    Item := TMenuItem.Create(Form4.UsersSites);
    Item.Caption := 'Все сайты';
    Item.OnClick := Form4.N5Click;
    Item.OnDrawItem := Form4.menu1OnDrawItem;
    Form4.UsersSites.OwnerDraw := true;
    Form4.UsersSites.Items.Add(Item);

    Form8.Hide;
    Form4.Show;
    NeedExit := false;
    Dec(QueueUpdates);
    SetTimer(Form4.Handle,QueueUpdates,1000,@Updates);
  end
  else
  begin
  //ShowMessage('Пользователь не найден!');
    Form4.Hide;
    Form8.Show;
  end;
end;
  HTTP.Destroy;
  SSL.Destroy;





 // Form4.DownloadJPG('alex.jpg',Form4.Image8);
end;
procedure TForm4.FormCreate(Sender: TObject);
var
  form: TForm;
  Doc: Variant;
  b : TButton;
  icon : TIcon;
  IcoStream : TMemoryStream;
  Reg:TRegistry;
  verion:string;
//  Folder: Pchar;
//  List: PitemidList;
begin
//SHGetSpecialFolderLocation(0,CSIDL_STARTUP,List);
//  new(folder);
//  SHGetPathFromIDList(List,folder);
//  ChDir(folder);
//  CopyFile(PChar(ExtractFilePath(paramStr(0)) + 'Nachalosaita.lnk'), 'Nachalosaita.lnk', true);
//  GlobalFreePtr(List);

//
    GlobalHTTPok := true;
    KeepOnlineInterval :=0;
    NeedExit2 :=false;
     Reg := TRegistry.Create;
     Reg.LazyWrite := false;
     Reg.RootKey := HKEY_CURRENT_USER; // HKEY_LOCAL_MACHINE;//
     Reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', true);
     Reg.WriteString(Application.Title, Application.ExeName);
     //Reg.DeleteValue('Nachalosaita');
     Reg.CloseKey;
     Reg.Free;

  PageControl1.Width:=Form4.Width - Panel2.Width;
  PageControl1.Height:=Form4.Height - Panel1.Height;
  PageControl1.Top:=-3;
  PageControl1.Left:=-3;

  PageControl1.ActivePage := TabSheet3;
      SetLength(Ops1,0);
  NeedExit := false;
  IcoStream := TMemoryStream.Create;
  IcoStream.Position := 0;Image17.Picture.SaveToStream(IcoStream);IcoStream.Position := 0;
  icon := TIcon.Create;
  icon.LoadFromStream(IcoStream);
  icon.Height := 16;
  icon.Width := 16;
  AllUsers.Items[3].Bitmap.SetSize(16,16);
  AllUsers.Items[3].Bitmap.Canvas.Draw(0,0,icon);
  IcoStream.Position := 0;Image18.Picture.SaveToStream(IcoStream);IcoStream.Position := 0;
  icon.LoadFromStream(IcoStream);
  icon.Height := 16;
  icon.Width := 16;
  AllUsers.Items[2].Bitmap.SetSize(16,16);
  AllUsers.Items[2].Bitmap.Canvas.Draw(0,0,icon);
  IcoStream.Position := 0;Image19.Picture.SaveToStream(IcoStream);IcoStream.Position := 0;
  icon.LoadFromStream(IcoStream);
  icon.Height := 16;
  icon.Width := 16;
  AllUsers.Items[1].Bitmap.SetSize(16,16);
  AllUsers.Items[1].Bitmap.Canvas.Draw(0,0,icon);

  IcoStream.Position := 0;Image21.Picture.SaveToStream(IcoStream);IcoStream.Position := 0;
  icon.LoadFromStream(IcoStream);
  icon.Height := 16;
  icon.Width := 16;
  AllUsers.Items[4].Bitmap.SetSize(16,16);
  AllUsers.Items[4].Bitmap.Canvas.Draw(0,0,icon);

  IcoStream.Position := 0;Image20.Picture.SaveToStream(IcoStream);IcoStream.Position := 0;
  Application.Icon.LoadFromStream(IcoStream);
  IcoStream.Free;

  verion := 'Начало сайта 1.43';
 Application.Title := verion;
 Form4.Caption := verion;
 Form8.Caption := verion;
 Application.ShowHint := True;
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
  Form4.Hide;



  if NOT Assigned(WebBrowser1.Document) then
    WebBrowser1.Navigate('about:blank');

  Doc := WebBrowser1.Document;
  Doc.Clear;
  Doc.Write('<html><meta charset="UTF-8"> <style> div.style7{horizontcal-align: right;height: 120px; width: 213px; left: 0px; position: relative; top: 0px; border: 0px;background:#FFFFFF;break-word;}div.style8{overflow-'+
  'wrap:break-word;word-wrap:break-word;width: 343px; left: 0px; font-family:'+
  ' Arial; color: #FFFFFF; background'+
':#3DC76F; vertical-align: middle;padding-left: 10px;padding-right: 5px;padding-top: 5px;padding-bottom: 5px;border-left: 20px solid #FFFFFF;border-top: 20px solid #FFFFFF;font-size: 14px;position: relative;border-image: url("https://nachalosaita.itgroup.'+
'kz/img/l2.png") 40 / 40px 0px 0px 20px ; background-clip: padding-box;}div.style9{overflow-wrap:break-word;word-wrap:break-word;width: 343px; left: 230px; font-family: Arial; color: #000000; background:#EDEDED; vertical-align: middle;padding-left: 10px;'+
'padding-right: 5px;padding-top: 5px;padding-bot'+
'tom: 5px;border-right: 20px solid #FFFFFF;border-top: 20px solid #FFFFFF;font-size: 15px;position: relative;border-image: url("https://nachalosaita.itgroup.kz/img/l3.png") 40 / 40px 20px 0px 20px ; background-clip: padding-box;}div.style10{overflow-wrap:'+
'break-word;word-wrap:break-word;width: 343px; left: 0px; font-family: Arial; color: #999999; background:#FFFFFF; vertical-align: middle;padding-left: 10px;padding-righ' +
't: 5px;padding-top: 5px;padding-bot'+
'tom: 5px;border-right: 20px solid #FFFFFF;border-top: 20px solid #FFFFFF;font-size: 15px;position: relative;border-image: url("https://nachalosaita.itgroup.kz/img/l3.png") 40 / 40px 20px 0px 20px ; background-clip: padding-box;}</style> <script type="'+
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
  SetTimer(Application.Handle,Queue,20,@Proc);


end;

procedure TForm4.StartMainTimer();
begin
  Inc(Queue);
  SetTimer(Application.Handle,Queue,20,@Proc);
end;

procedure TForm4.FormDestroy(Sender: TObject);
begin
  Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
end;

procedure TForm4.FormPaint(Sender: TObject);
var
  form_hdc:HDC;
begin
//  Canvas.Pen.Color:=$00D8D4D2;
//  Canvas.Pen.Color:=$000000FF;
//  form_hdc:=Canvas.Handle;
//  Rectangle(form_hdc, Memo1.Left - 1, Memo1.Top - 1, Memo1.Left + Memo1.Width + 2, Memo1.Top + Memo1.Height + 2);
end;

procedure TForm4.FormResize(Sender: TObject);
begin
  PageControl1.Width:=Form4.Width - Panel2.Width;
  PageControl1.Height:=Form4.Height - Panel1.Height;
  PageControl1.Top:=-3;
  PageControl1.Left:=-3;
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
  V,v1 : WideString;
  i,i1: integer;
  formattedDateTime,t1 : string;

 Buffer: String;
 HTTP: TIdHTTP;
 data: TIdMultiPartFormDataStream;
 SSL:TIdSSLIOHandlerSocketOpenSSL;
 StartOTUD:TStartOTUD;
 document :IHTMLDocument2;
begin
    myDate :=  Now;
    for i := 0 to ( Memo1.Lines.Count - 1 ) do
    begin
      t1 := Memo1.Lines[i];
      while Pos(('\\'),t1)>0 do t1 := StringReplace(t1, '\\', '\',[rfReplaceAll, rfIgnoreCase]);
      while Pos(('\"'),t1)>0 do t1 := StringReplace(t1, '\"', '"',[rfReplaceAll, rfIgnoreCase]);
      while Pos(('"'),t1)>0 do t1 := StringReplace(t1, '"', '`',[rfReplaceAll, rfIgnoreCase]);
      while Pos((#39),t1)>0 do t1 := StringReplace(t1, #39, '`',[rfReplaceAll, rfIgnoreCase]);
       V := v + t1 + #10#13;DateTimeToString(formattedDateTime,'yyyy-mm-dd hh:nn:ss',myDate);
    end;
    Memo1.Lines.Text := '';
    v1 := '<div class="style8" title="'+formattedDateTime+'"><font size="2" color="#F0F0F0" face="Arial">'+formattedDateTime+'</font><br><b>'+Label20.Caption+'</b><br>'+v+ '</div>';
    //CallFoo( v, 0, formattedDateTime);
    document := Form4.webBrowser1.Document as IHTMLDocument2;
    document.body.innerHTML := Copy(document.body.innerHTML,1,Length(document.body.innerHTML)-12) + v1 + '</div></div>';

    WebBrowser1.OleObject.Document.ParentWindow.ScrollBy(0, 100000);
    //ScrollBox1.VertScrollBar.Position:=ScrollBox1.VertScrollBar.Position+100;

  data := TIdMultiPartFormDataStream.Create;
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

  for I := 0 to ScrollBox1.ComponentCount-1 do
  begin
    if (ScrollBox1.Components[I] as TPanel).Color = clWhite then i1:=(ScrollBox1.Components[I] as TPanel).Tag;
  end;


  data := TIdMultiPartFormDataStream.Create;
  data.AddFormField('csrf_token', Cookie);
  data.AddFormField('userid', i1.ToString);
  data.AddFormField('msg', UTF8Encode(v), 'utf-8').ContentTransfer := '8bit';
  HTTP.Request.CustomHeaders.text := 'Cookie: MibewSessionID='+MibewSessionID+'; ';

   try
    Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/operator/message',data);
   except
    ShowMessage('Отсутствует связь с сервером' + #10#13);
    Exit;
   end;

  HTTP.Destroy;
  SSL.Destroy;

end;


procedure TForm4.Image3Click(Sender: TObject);
begin
PopupMenu2.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TForm4.Label18Click(Sender: TObject);
var
Operators1 :TOperators1;
i:integer;
begin
Form5.Show;
Form5.Left := Label18.ClientOrigin.X-22;
Form5.Top := Label18.ClientOrigin.Y-Form5.Height;
  SetLength(Operators1,length(Operators));
  for i := 0 to length(Operators)-1 do
  begin
  Operators1[i].id := Operators[i].id;
  Operators1[i].name := Operators[i].name;
  Operators1[i].status := Operators[i].status;
  Operators1[i].jpgname := Operators[i].jpgname;
  //Operators1[i].sitesdepts := Operators[i].sitesdepts;
  end;
Form5.SetOpsWindow(Operators1,Edit1.Tag);
end;

procedure TForm4.Label19Click(Sender: TObject);
var
Buffer: String;
 HTTP: TIdHTTP;
 data: TIdMultiPartFormDataStream;
 S,s1:String;
 SSL:TIdSSLIOHandlerSocketOpenSSL;
 i,j:integer;
begin
  data := TIdMultiPartFormDataStream.Create;
  data.AddFormField('csrf_token', cookie);
  data.AddFormField('address', IntToStr(Edit1.Tag));
  data.AddFormField('days', IntToStr(3));
  data.AddFormField('comment', UTF8Encode('Не желательный пользователь'), 'utf-8').ContentTransfer := '8bit';

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
    Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/ban',data);
  except
    ShowMessage('Отсутствует связь с сервером' + #10#13);
    Exit;
  end;

Form4.PageControl1.ActivePage := Form4.TabSheet4;
for i := 0 to Form4.ScrollBox1.ComponentCount -1 do
if (Form4.ScrollBox1.Components[i] as TPanel).Tag = Edit1.Tag then j:=i;

//Form4.TabbedNotebook1.PageIndex := 2;
Form4.PageControl1.ActivePage := Form4.TabSheet3;
Dialogs.curuser := 0;

Form4.DeleteDialogUser(Form4.GetDialogUserId(UserID1));
(Form4.ScrollBox1.Components[j] as TPanel).Destroy;

  HTTP.Destroy;
  SSL.Destroy;
end;

procedure TForm4.Label24Click(Sender: TObject);
var
  l : TLabel;
  i : integer;
 HTTP: TIdHTTP;
 data: TIdMultiPartFormDataStream;
 Buffer:String;
 SSL:TIdSSLIOHandlerSocketOpenSSL;
begin
  l := Sender as TLabel;
  data := TIdMultiPartFormDataStream.Create;
  data.AddFormField('csrf_token', Cookie);
  data.AddFormField('userid', IntToStr((l.Parent as TPanel).Tag));

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
    Buffer := HTTP.Post('https://test3.console.vipsite.kz/api-chat/user/close',data);
  except
    ShowMessage('Отсутствует связь с сервером' + #10#13);
    Exit;
  end;
  //  Form4.Memo3.Text := Buffer;


  Form6.Hide;

  if (l.Parent as TPanel).Color = clWhite then
  begin
    //TabbedNotebook1.PageIndex := 2;
    PageControl1.ActivePage := TabSheet3;
    Dialogs.curuser := 0;
  end;

  DeleteDialogUser(GetDialogUserId((l.Parent as TPanel).Tag));
  l.Parent.Destroy;
  HTTP.Destroy;
  SSL.Destroy;
end;

procedure TForm4.Label25Click(Sender: TObject);
begin
AllUsers.Popup(Label25.ClientOrigin.X,Label25.ClientOrigin.Y + Label25.Height);
Application.ProcessMessages;
end;

procedure TForm4.Label26Click(Sender: TObject);
begin
UsersSites.Popup(Label26.ClientOrigin.X,Label26.ClientOrigin.Y + Label26.Height);
Application.ProcessMessages;
end;

procedure TForm4.Label28Click(Sender: TObject);
begin
OpsSites.Popup(Label28.ClientOrigin.X,Label28.ClientOrigin.Y + Label28.Height);
Application.ProcessMessages;
end;

procedure TForm4.Label2Click(Sender: TObject);
begin
//TabbedNotebook1.PageIndex := 0;
PageControl1.ActivePage := TabSheet0;
end;

procedure TForm4.Label35Click(Sender: TObject);
begin
Departments.Popup(Label35.ClientOrigin.X,Label28.ClientOrigin.Y + Label35.Height);
Application.ProcessMessages;
end;

procedure TForm4.Label3Click(Sender: TObject);
begin
//TabbedNotebook1.PageIndex := 1;
PageControl1.ActivePage := TabSheet2;
end;

procedure TForm4.Label4Click(Sender: TObject);
begin
//TabbedNotebook1.PageIndex := 2;
PageControl1.ActivePage := TabSheet3;
end;

procedure TForm4.Label5Click(Sender: TObject);
var
ini: TRegIniFile;
 HTTP: TIdHTTP;
 data: TIdMultiPartFormDataStream;
 SSL:TIdSSLIOHandlerSocketOpenSSL;
 Buffer: string;

begin
  NeedExit2 := true;
  Form4.Hide;
  Form8.Show;

  data := TIdMultiPartFormDataStream.Create;
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
  end;




//TabbedNotebook1.PageIndex := 3;
//  NeedExit := true;
  ini := TRegIniFile.Create('Software\Nachalosaita');
  try
  ini.WriteString('cookie', 'cookie', '0');
  ini.WriteString('cookie', 'login', '0');
  ini.WriteString('cookie', 'password', '0');
  finally
   ini.Free;
  end;
end;

procedure TForm4.N1Click(Sender: TObject);
begin
   Memo1.Lines.Text := 'Здравствуйте, чем я могу вам помочь?';
end;

procedure TForm4.N2Click(Sender: TObject);
begin
   Memo1.Lines.Text := 'До свидания!';
end;

procedure TForm4.N4Click(Sender: TObject);
var
i:integer;
begin
  Label25.Caption := TMenuItem(Sender).Caption;
  HandleUsersSites();
end;
procedure TForm4.N5Click(Sender: TObject);
begin
  Label26.Caption := TMenuItem(Sender).Caption;
  HandleUsersSites();
end;
procedure TForm4.PageControl1Resize(Sender: TObject);
begin
  PageControl1.Width:=Form4.Width - Panel2.Width;
  PageControl1.Height:=Form4.Height - Panel1.Height;
  PageControl1.Top:=-3;
  PageControl1.Left:=-3;
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
    (ScrollBox1.Components[I] as TPanel).Color := $00EEEEEE;
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
    Edit1.Tag := Dialogs.users[i].id;
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
    WebBrowser1.OleObject.Document.ParentWindow.ScrollBy(0, 100000);
    Dialogs.curuser := 1;
  end;
  if(Sender is TPanel)then
  begin
    (Sender as TPanel).Color := clWhite;
  end
  else
  ((Sender as TLabel).Parent as TPanel).Color := clWhite;

  //TabbedNotebook1.PageIndex := 4;
  PageControl1.ActivePage := TabSheet4;

//ShowMessage(p.Tag.ToString);
end;
function getSites(JsonString: String): TSitesArray;
var
  JSonValue: TJSonValue;
  JsonArray,JsonArray2: TJSONArray;
  ArrayElement,ArrayElement2: TJSonValue;
  FoundValue: TJSonValue;
  i:integer;
begin
  SetLength(Result,0);
  JsonValue := TJSonObject.ParseJSONValue(JsonString);
  JsonArray := JsonValue.GetValue<TJSONArray>('sites');
  for ArrayElement in JsonArray do begin
      //if ArrayElement.GetValue<String>('id') = User then begin
      //for ArrayElement2 in JsonArray2 do begin
        SetLength(Result,length(Result)+1);
        Result[length(Result)-1].id := ArrayElement.GetValue<String>('id');
        Result[length(Result)-1].site := ArrayElement.GetValue<String>('site');
        JsonArray2 := ArrayElement.GetValue<TJSONArray>('departments');
        SetLength(Result[length(Result)-1].department,0);i:=0;
        for ArrayElement2 in JsonArray2 do
        begin
          SetLength(Result[length(Result)-1].department,length(Result[length(Result)-1].department)+1);
          Result[length(Result)-1].department[i].department :=ArrayElement2.GetValue<String>('department');
          i:=i+1;
        end;
      //  break;
      //end;
  end;
  //Result := Result + JsonValue.GetValue<String>('cookies');
end;
function getJSONItem(JsonString: String; Field: String): String;
var
  JSonValue: TJSonValue;
begin
  JsonValue := TJSonObject.ParseJSONValue(JsonString);
  Result := JsonValue.GetValue<String>(Field);
end;
procedure TForm4.Exit1Click(Sender: TObject);
begin
 MustExit:=true;
 Close;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 needexit :=true;
 if MustExit then
 begin
 //Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
 exit;
 end;
 //Form4.Hide;
 //Close;
 Action:=caNone;
end;

procedure TForm4.InsertUserToDialogs(id: Integer;newmsgcnt: string;name: string; phone: string;
      email: string;comment: string;ip: string;urlfrom: string;urlto: string;view: string;
      onsitetime: string;pageviews: string;visits: string;optypemsg: string;innerHTML: WideString; msgtime:string; visittime:string);
var
  i,j:integer;

panel : TPanel;
labelClose : TLabel;
labelName : TLabel;
labelEmail : TLabel;
labelMsgcount : TLabel;
document :IHTMLDocument2;
begin
  i := -1;//length(Dialogs.users);
  for j := 0 to length(Dialogs.users)-1 do
    begin
       if Dialogs.users[j].id = id then i := j;
    end;
  if i = -1 then
  begin
    i := length(Dialogs.users);
    Dialogs.userscount := Dialogs.userscount + 1;

    panel :=TPanel.Create(nil);
    panel.Parent := ScrollBox1;
    panel.Align := alTop;
    if ScrollBox1.ComponentCount >0 then
    panel.Top := (ScrollBox1.Components[ScrollBox1.ComponentCount-1] as TPanel).Top;

    panel.Tag := id;
    panel.OnClick := Panel14Click;
    panel.ParentBackground := false;
    panel.Color := $00EEEEEE;
    panel.ShowCaption := false;

    labelClose :=TLabel.Create(nil);
    labelClose.Parent := panel;
    labelClose.Caption := 'x';
    labelClose.Align := alRight;
    labelClose.Width := 15;
    labelClose.Color := $00A69C99;
    labelClose.Layout := tlCenter;
    labelClose.OnClick := Label24Click;

    labelName :=TLabel.Create(nil);
    labelName.Parent := panel; labelName.OnClick := Panel14Click;
    labelName.Caption := name;labelName.Left := 8;labelName.Top := 6;labelName.Width := 120;
    labelName.Font.Color := $006F5F5B; labelName.Font.Name := 'Arial'; labelName.Font.Height := -13;//labelName.Font.Style := [fsBold];

    labelEmail :=TLabel.Create(nil);
    labelEmail.Parent := panel; labelEmail.OnClick := Panel14Click;
    labelEmail.Caption := email;labelEmail.Left := 7;labelEmail.Top := 23;labelEmail.Width := 120;
    labelEmail.Font.Color := $006F5F5B; labelEmail.Font.Name := 'Arial'; labelEmail.Font.Height := -13;

    labelMsgcount :=TLabel.Create(nil);
    labelMsgcount.Parent := panel; labelMsgcount.OnClick := Panel14Click;labelMsgcount.Align := alRight;
    labelMsgcount.Caption := newmsgcnt;labelMsgcount.Width := 15;labelMsgcount.Layout := tlCenter; labelMsgcount.AutoSize := false;
    labelMsgcount.Font.Color := clRed; labelMsgcount.Font.Name := 'Arial'; labelMsgcount.Font.Height := -12;labelMsgcount.Font.Style := [fsBold];

    panel.InsertComponent(labelMsgcount);
    panel.InsertComponent(labelName);
    panel.InsertComponent(labelEmail);
    panel.InsertComponent(labelClose);

    ScrollBox1.InsertComponent(panel);
    ScrollBox1.Update;
    ScrollBox1.Invalidate;

    SetLength(Dialogs.users, length(Dialogs.users)+1);
    if newmsgcnt <> '' then Form6.FormShow('Есть новые сообщения',labelName.Caption, labelEmail.Caption);
  end
  else
  begin
    for j := 0 to ScrollBox1.ComponentCount-1 do
    begin
      if ((ScrollBox1.Components[j] as TPanel).Tag = id) and ((ScrollBox1.Components[j] as TPanel).Color <> clWhite) then
      begin
      ((ScrollBox1.Components[j] as TPanel).Components[0] as TLabel).Caption := newmsgcnt;
      document := webBrowser1.Document as IHTMLDocument2;
      document.body.innerHTML := innerHTML;
      WebBrowser1.OleObject.Document.ParentWindow.ScrollBy(0, 100000);
      Form6.FormShow('Есть новые сообщения',labelName.Caption,labelEmail.Caption);
      end;
    end;
  end;
  if (i<>-1) and (length(Dialogs.users)>0) then
  begin
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
    Dialogs.users[i].msgtime := msgtime;
    Dialogs.users[i].visittime := visittime;
  end;
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
