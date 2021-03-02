unit Unit1;

interface

uses
 Windows, Classes, Messages, Controls, Forms, ExtCtrls, Graphics,
 SysUtils, ShellApi;

type
 TAlertDirection = (adNone, adUp, adDown, adLeft, adRight);
 TOnShow = procedure (Sender: TObject) of object;
 TOnClose = procedure (Sender: TObject) of object;

type
TAlertWindow = class(TCustomControl)
 private
  FAlertDirection: TAlertDirection;
   FCloseDelay: Integer;
   FDelayTimer: TTimer;
   FForegroundColor: TColor;
   FInProgress: Boolean;
   FOnShow: TOnShow;
   FOnClose: TOnClose;
   TaskBarRect: TRect;
   function FindTaskbar(var ARect: TRect): Integer;
   procedure GetTaskBar;
   procedure SetCloseDelay(const Value: Integer);
   procedure SetForegroundColor(const Value: TColor);
   procedure GoPopUp;
 protected
   procedure CreateParams(var Params: TCreateParams); override;
   procedure CreateWnd; override;
   procedure DoDelayTimer(Sender: TObject);
   procedure Paint; override;
   procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
   procedure WMSize(var Message: TWMSize); message WM_SIZE;
 public
  constructor Create(AOwner: TComponent); override;
  procedure PopUp;
  procedure CloseUp;
   procedure Show(X, Y: Integer);
 published
   property CloseDelay: Integer read FCloseDelay write SetCloseDelay;
   property Font;
   property ForegroundColor: TColor read FForegroundColor write SetForegroundColor;
   property OnShow: TOnShow read FOnShow write FOnShow;
   property OnClose: TOnClose read FOnClose write FOnClose;
   property OnClick;
   property OnContextPopup;
   property OnDblClick;
   property OnDragDrop;
   property OnDragOver;
   property OnEndDock;
   property OnEndDrag;
   property OnMouseDown;
   property OnMouseMove;
   property OnMouseUp;
   property OnStartDock;
   property OnStartDrag;
 end;

procedure Register;

var
 TaskBarPos: Cardinal;

implementation

//------------------------------------------------------------------------------

procedure Register;
begin
 RegisterComponents('Samples', [TAlertWindow]);
end;

//------------------------------------------------------------------------------

function WindowAnimate(Wnd: HWND; dwTime: DWORD; dwFlags: DWORD): BOOL;
type
 TWndAnimate = function (h: HWND; Time: DWORD; Flags: DWORD): BOOL; stdcall;
var
 WndAnimate: TWndAnimate;
begin
 @WndAnimate := GetProcAddress(GetModuleHandle(PChar('user32.dll')), PChar('AnimateWindow'));
 Result := Assigned(@WndAnimate);
 if Result then
   Result := WndAnimate(Wnd, dwTime, dwFlags);

end;

//------------------------------------------------------------------------------

constructor TAlertWindow.Create(AOwner: TComponent);
begin
 inherited;
 Visible := csDesigning in ComponentState;
 ControlStyle := ControlStyle + [csAcceptsControls, csReplicatable];
 FAlertDirection := adNone;
 FCloseDelay := 5000;
 FForegroundColor := clInfoBk;
 FInProgress := False;
 FDelayTimer := TTimer.Create(Self);
 FDelayTimer.Enabled := False;
 FDelayTimer.OnTimer := DoDelayTimer;
 FDelayTimer.Interval := FCloseDelay;
 FOnShow := nil;
 ParentColor := true;
 Height := 150;
 Width := 150;
end;

//------------------------------------------------------------------------------

procedure TAlertWindow.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
 with Params do
  if not (csDesigning in ComponentState) then
   begin
    WndParent:= GetDesktopWindow;
     Style:= WS_CLIPSIBLINGS or WS_CHILD;
    ExStyle:= WS_EX_TOPMOST or WS_EX_TOOLWINDOW;
     WindowClass.Style:= CS_DBLCLKS or CS_SAVEBITS and not(CS_HREDRAW or CS_VREDRAW);
  end;
end;

//------------------------------------------------------------------------------

procedure TAlertWindow.CreateWnd;
begin
 inherited;
end;

//------------------------------------------------------------------------------

procedure TAlertWindow.SetCloseDelay(const Value: Integer);
begin
 FCloseDelay := Value;
 FDelayTimer.Interval := Value;
end;

//------------------------------------------------------------------------------

procedure TAlertWindow.SetForegroundColor(const Value: TColor);
begin
 FForegroundColor := Value;
 Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAlertWindow.DoDelayTimer(Sender: TObject);
begin
 FInProgress := False;
 FDelayTimer.Enabled := False;
 CloseUp;
end;

procedure TAlertWindow.GoPopUp;
begin
 if Assigned(FOnShow) then FOnShow(Self);
 case FAlertDirection of
   adUp:
   begin
     SetWindowPos(Handle, HWND_TOPMOST, TaskbarRect.Right - Width,
                                        TaskbarRect.Top - Height,
                                        Width,
                                        Height,
                                        SWP_HIDEWINDOW);
     AnimateWindow(Handle, 500, AW_VER_NEGATIVE or AW_SLIDE);
     FDelayTimer.Enabled := True;
   end;

   adDown:
   begin
     SetWindowPos(Handle, HWND_TOPMOST, TaskbarRect.Right - Width,
                                        TaskbarRect.Bottom,
                                        Width,
                                        Height,
                                        SWP_HIDEWINDOW);
     AnimateWindow(Handle, 500, AW_VER_POSITIVE or AW_SLIDE);
     FDelayTimer.Enabled := True;
   end;
   adLeft:
   begin
     SetWindowPos(Handle, HWND_TOPMOST,  TaskbarRect.Left - Width,
                                         TaskbarRect.Bottom - Height,
                                         Width,
                                         Height,
                                         SWP_HIDEWINDOW);
     AnimateWindow(Handle, 500, AW_HOR_NEGATIVE or AW_SLIDE);
     FDelayTimer.Enabled := True;
   end;
   adRight:
   begin
     SetWindowPos(Handle, HWND_TOPMOST, TaskbarRect.Right,
                                        TaskbarRect.Bottom - Height,
                                        Width,
                                        Height,
                                        SWP_HIDEWINDOW);
     AnimateWindow(Handle, 500, AW_HOR_POSITIVE or AW_SLIDE);
     FDelayTimer.Enabled := True;
   end;
 end;
end;

//------------------------------------------------------------------------------

procedure TAlertWindow.CloseUp;
var
 OldPos: Cardinal;
begin
 if Assigned(FOnClose) then FOnClose(Self);
 OldPos := TaskBarPos;
 GetTaskBar;
 FDelayTimer.Enabled := False;
 if OldPos <> TaskBarPos then
   FAlertDirection := adNone;

 case FAlertDirection of
   adUp:
     AnimateWindow(Handle, 500, AW_VER_POSITIVE or AW_SLIDE or AW_HIDE);
   adDown:
     AnimateWindow(Handle, 500, AW_VER_NEGATIVE or AW_SLIDE or AW_HIDE);
   adLeft:
     AnimateWindow(Handle, 500, AW_HOR_POSITIVE or AW_SLIDE or AW_HIDE);
   adRight:
     AnimateWindow(Handle, 500, AW_HOR_NEGATIVE or AW_SLIDE or AW_HIDE);
   adNone:
     AnimateWindow(Handle, 500, AW_CENTER or AW_SLIDE or AW_HIDE);
 end;
end;

//------------------------------------------------------------------------------

procedure TAlertWindow.Show(X, Y: Integer);
begin
 if Assigned(FOnShow) then FOnShow(Self);
 FInProgress := True;
 SetWindowPos(Handle, HWND_TOPMOST, X, Y,
              Width, Height, SWP_HIDEWINDOW);
 AnimateWindow(Handle, 500, AW_CENTER + AW_SLIDE);
 FAlertDirection := adNone;
 FDelayTimer.Enabled := True;
end;

//------------------------------------------------------------------------------

procedure TAlertWindow.WMNCPaint(var Message: TMessage);
begin
 inherited;
end;

//------------------------------------------------------------------------------

procedure TAlertWindow.WMSize(var Message: TWMSize);
begin
 inherited;
end;

//------------------------------------------------------------------------------

procedure TAlertWindow.Paint;
var
 R: TRect;
begin
 inherited;
with Canvas do
 begin
   Brush.Color:= ForegroundColor;
   FillRect(ClientRect);
   R := ClientRect;
   OffsetRect(R, R.Left, R.Top);
   DrawEdge(Handle, R, EDGE_RAISED, BF_RECT);
   InflateRect(R, -2, -2);
   DrawEdge(Handle, R, EDGE_SUNKEN, BF_RECT);
 end;
end;

//------------------------------------------------------------------------------

procedure TAlertWindow.Popup;
begin
 ShowWindow(Handle, SW_HIDE);
 GetTaskBar;
 case TaskBarPos of
   ABE_BOTTOM:
    FAlertDirection := adUp;
   ABE_TOP:
     FAlertDirection := adDown;
   ABE_LEFT:
     FAlertDirection := adRight;
   ABE_RIGHT:
     FAlertDirection := adLeft;
 end;
 FInProgress:= True;
 GoPopUp;
end;

//------------------------------------------------------------------------------

function TAlertWindow.FindTaskbar(var ARect: TRect): Integer;
var
AppData: TAppBarData;
begin
 ZeroMemory(@AppData, SizeOf(TAppBarData));
 AppData.rc := Rect(0, Screen.Height, Screen.Width, Screen.Height);
 AppData.Hwnd := FindWindow('Shell_TrayWnd', nil);
 AppData.uEdge := ABE_BOTTOM;
 AppData.cbSize:= SizeOf(TAppBarData);
 if AppData.Hwnd <> 0 then
   SHAppBarMessage(ABM_GETTASKBARPOS, AppData);
 Result := AppData.uEdge;
 ARect := AppData.rc;
end;

//------------------------------------------------------------------------------

procedure TAlertWindow.GetTaskBar;
begin
 TaskBarPos := FindTaskBar(TaskBarRect);
end;


end.
