unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellAPI, StdCtrls, Menus;

const WM_ICONTRAY = WM_USER+1;

type
  TForm3 = class(TForm)
    PopupMenu1: TPopupMenu;
    ShowForm1: TMenuItem;
    HideForm1: TMenuItem;
    Exit1: TMenuItem;
    procedure TrayMessage(var Msg: TMessage); message WM_ICONTRAY;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ShowForm1Click(Sender: TObject);
    procedure HideForm1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
   TrayIconData: TNotifyIconData;
  end;

var
  Form1: TForm3;
  MustExit:boolean;

implementation

{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);
begin
  MustExit:=false;
  TrayIconData.cbSize:=SizeOf(TrayIconData);
  TrayIconData.Wnd:=Handle;
  TrayIconData.uID:=0;
  TrayIconData.uFlags:=NIF_MESSAGE + NIF_ICON + NIF_TIP;
  TrayIconData.uCallbackMessage:=WM_ICONTRAY;
  TrayIconData.hIcon:=Application.Icon.Handle;
  StrPCopy(TrayIconData.szTip,Application.Title);
  Shell_NotifyIcon(NIM_ADD, @TrayIconData);
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
  Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
end;

procedure TForm3.TrayMessage(var Msg: TMessage);
var p:TPoint;
begin
  case Msg.lParam of
    WM_LBUTTONDOWN: begin
                     Form1.Show;
                     Application.Restore;
                    end;
    WM_RBUTTONDOWN: begin
                     GetCursorPos(p);
                     PopUpMenu1.Popup(p.x,p.y);
                    end;
  end;
end;

// Popup "Form Show" menu item OnClick
procedure TForm3.ShowForm1Click(Sender: TObject);
begin
 Form1.Show;
end;

// Popup "Form Hide" menu item OnClick
procedure TForm3.HideForm1Click(Sender: TObject);
begin
 Form1.Hide;
end;

// Popup "Exit" menu item OnClick
procedure TForm3.Exit1Click(Sender: TObject);
begin
 MustExit:=true;
 Close;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if MustExit then exit;
 Form1.Hide;
 Action:=caNone;
end;

end.
