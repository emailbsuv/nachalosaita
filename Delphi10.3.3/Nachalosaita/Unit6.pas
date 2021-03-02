unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls,MMSystem;

type
  TForm6 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(msg:string);
    procedure Image3Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);

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
begin
 SystemParametersInfo(SPI_GETWORKAREA, 0, @rect, 0);
 Left:=(GetSystemMetrics(0)-Width) ;
 Top:=(rect.Bottom-Height);
 //Form6.Hide();
end;
procedure TForm6.FormShow(msg:string);
var
handle1 : THandle;
begin
 Form6.Show;
 Label1.Caption := msg;
 //beep;
 TSpeakThread.Create(false);
 handle1 := Form6.Handle;
 SetWindowLong(handle1,GWL_EXSTYLE,GetWindowLong(Handle1, GWL_EXSTYLE) or not WS_EX_APPWINDOW or WS_EX_TOPMOST);
 AnimateWindow(Handle1, 0, AW_BLEND);
 SetClassLong(handle1, GCL_HBRBACKGROUND, CreateSolidBrush($F0CAA6));
 SetWindowLong(handle1,GWL_EXSTYLE,GetWindowLong(Handle1, GWL_EXSTYLE) or WS_EX_LAYERED);
 SetLayeredWindowAttributes(handle1,
                            $65,//rgb(255,255,255),
                            200,
                            LWA_ALPHA or LWA_COLORKEY);
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
