unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls,MMSystem;

type
  TForm6 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Image4: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Image2: TImage;
    Image3: TImage;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(msg:string; username:string; sitename:string);
    procedure Image3Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
TSpeakThread = class(TThread)
protected

  procedure Execute; override;
  end;
var
  Form6: TForm6;

implementation

{$R *.dfm} {$R ding.RES}
//{//$//R //png.RES}
uses Unit4;


procedure TSpeakThread.Execute;
begin
  inherited;
    FreeOnTerminate:= True;
  try
      PlaySound('ding', hInstance, SND_RESOURCE or SND_SYNC);
  finally
  end;
end;

procedure TForm6.FormCreate(Sender: TObject);
var
rect: trect;
rgn: HRGN;
begin
 SystemParametersInfo(SPI_GETWORKAREA, 0, @rect, 0);
 Left:=(GetSystemMetrics(0)-Width-15) ;
 Top:=(rect.Bottom-Height-30);


  Form6.Borderstyle := bsNone;
  rgn := CreateRoundRectRgn(0,0,ClientWidth,ClientHeight,24,24);
  SetWindowRgn(Handle, rgn, True);


 //Form6.Hide();
end;
procedure TForm6.FormPaint(Sender: TObject);
//var
// pngimg: TPNGObject;
begin
// pngimg:= TPNGObject.Create;
// pngimg.LoadFromResourceName(HInstance, 'img');
// Form6.Canvas.Draw(-4,-5,pngimg);
end;

procedure TForm6.FormShow(msg:string; username:string; sitename:string);
var
handle1 : THandle;
begin
 Form6.Show;
 Label1.Caption := Copy(username + ' - ' + sitename,1,35) + '..';
 Label3.Caption := Copy(msg,1,35) + '..';
 //beep;
 TSpeakThread.Create(false);
 {/
 handle1 := Form6.Handle;
 SetWindowLong(handle1,GWL_EXSTYLE,GetWindowLong(Handle1, GWL_EXSTYLE) or not WS_EX_APPWINDOW or WS_EX_TOPMOST);
 AnimateWindow(Handle1, 0, AW_BLEND);
 SetClassLong(handle1, GCL_HBRBACKGROUND, CreateSolidBrush($F0CAA6));
 SetWindowLong(handle1,GWL_EXSTYLE,GetWindowLong(Handle1, GWL_EXSTYLE) or WS_EX_LAYERED);
 SetLayeredWindowAttributes(handle1,
                            $65,//rgb(255,255,255),
                            200,
                            LWA_ALPHA or LWA_COLORKEY);
                            }
end;

procedure TForm6.Image1Click(Sender: TObject);
begin
Form6.Close;
end;

procedure TForm6.Image2Click(Sender: TObject);
begin
Form4.Show;
Form4.ScrollBox1.SetFocus;
//Form4.TabbedNotebook1.PageIndex := 2;
Form4.PageControl1.ActivePage := Form4.TabSheet3;
Form6.Hide;
end;

procedure TForm6.Image3Click(Sender: TObject);
begin
Form6.Close;
end;


end.
