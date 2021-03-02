unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,DateUtils,
  Vcl.StdCtrls;
type TUserSB1 = record
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
  TStartOTUD1 = array of record
  msg:string;
  dtime:string;
  toop:string;
end;
type
  TForm7 = class(TForm)
    Panel1: TPanel;
    Memo2: TMemo;
    Image1: TImage;
    Label17: TLabel;
    Label16: TLabel;
    Label15: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    Panel12: TPanel;
    Label11: TLabel;
    Label10: TLabel;
    Label23: TLabel;
    Label22: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Image5: TImage;
    Edit3: TEdit;
    Edit2: TEdit;
    Image4: TImage;
    Edit1: TEdit;
    procedure FormDeactivate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure SetUserInfo(UserSB: TUserSB1);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;
  UserID:integer;
  UserSB1:TUserSB1;
  StartOTUD1:TStartOTUD1;

implementation

{$R *.dfm}

uses Unit4;

procedure TForm7.SetUserInfo(UserSB: TUserSB1);
begin
  UserSB1 := UserSB;
  UserID := UserSB.id;
  if UserSB.name = '' then Edit1.Text := 'Имя' else Edit1.Text := UserSB.name;
  if UserSB.phone = '' then Edit2.Text := 'Телефон' else Edit2.Text := UserSB.phone;
  if UserSB.email = '' then Edit3.Text := 'Email' else Edit3.Text := UserSB.email;
  if UserSB.comment = '' then Memo2.Lines.Text := 'Добавить комментарий' else Memo2.Lines.Text := UserSB.comment;
  Label7.Caption := UserSB.ip;
  Label9.Caption := UserSB.urlfrom;
  Label23.Caption := UserSB.urlto;
  Label11.Caption := UserSB.view;
  Label13.Caption := UserSB.onsitetime;
  Label15.Caption := UserSB.pageviews;
  Label17.Caption := UserSB.visits;
end;
procedure TForm7.FormDeactivate(Sender: TObject);
begin
Form7.Hide;
end;

procedure TForm7.Image1Click(Sender: TObject);
var
i,j:integer;
t,msgs,tmp:string;

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

msgs := '';
t:= UserSB1.name; if t = '' then t:= UserSB1.ip;
StartOTUD1 := getOTUD(UserSB1.id);
 for i := 0 to Length(StartOTUD1)-1 do
 begin
    dtime := DateTimeToStr(IncMinute(StrToDateTime(StartOTUD1[i].dtime,FmtStngs),TimeInfo.Bias*-1),FmtStngs);
    if(StartOTUD1[i].toop='1')then
    begin
      tmp := '9';
      mcolor := 'A0A0A0';
    end
    else
    begin
      tmp := '8';
      mcolor := 'F0F0F0';
    end;
    msgs := msgs + '<div class="style'+tmp+'" title="'+dtime+'"><font size="2" color="#'+mcolor+'" face="Arial">'+dtime+'</font><br>'+StartOTUD1[i].msg + '</div>';
 end;

Form4.InsertUserToDialogs(UserSB1.id,'',t,UserSB1.phone,UserSB1.email,
      Memo2.Lines.Text,UserSB1.ip,UserSB1.urlfrom,UserSB1.urlto,UserSB1.view,
      UserSB1.onsitetime,UserSB1.pageviews,UserSB1.visits,'Здравствуйте, чем я могу вам помочь?','<div class="style7" id="chatform"><div id="mainform" style="transform: translateY(0px);" height="100%">'+msgs+'</div></div>',UserSB1.msgtime,UserSB1.visittime);
//Form4.TabbedNotebook1.PageIndex := 4;
Form4.PageControl1.ActivePage := Form4.TabSheet4;
for i := 0 to Form4.ScrollBox1.ComponentCount -1 do
   if (Form4.ScrollBox1.Components[i] as TPanel).Tag = UserSB1.id then j:=i;

SendMessage((Form4.ScrollBox1.Components[j] as TPanel).Handle,WM_LBUTTONDOWN, 10, 10);
SendMessage((Form4.ScrollBox1.Components[j] as TPanel).Handle,WM_LBUTTONUP, 10, 10);
Form7.Hide;
end;

end.
