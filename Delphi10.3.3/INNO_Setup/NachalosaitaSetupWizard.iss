; -- Languages.iss --
; Demonstrates a multilingual installation.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!

[Setup]
AppName={cm:MyAppName}
AppId=Началосайта
AppVerName={cm:MyAppVerName,1.135}
WizardStyle=modern
DefaultDirName={autopf}\{cm:MyAppName}
DefaultGroupName={cm:MyAppName}
UninstallDisplayIcon={app}\Nachalosaita.exe
VersionInfoDescription=Началосайта Установка
VersionInfoProductName=Началосайта
OutputDir=userdocs:Inno Setup Examples Output
SetupIconFile=Nachalosaita.ico
Compression=lzma2
SolidCompression=yes
PrivilegesRequiredOverridesAllowed=dialog
; Uncomment the following line to disable the "Select Setup Language"
; dialog and have it rely solely on auto-detection.
;ShowLanguageDialog=no

[Languages]
Name: ru; MessagesFile: "compiler:Languages\Russian.isl"


[Messages]
ru.BeveledLabel=Русский

[CustomMessages]
ru.MyDescription=Началосайта
ru.MyAppName=Началосайта
ru.MyAppVerName=Началосайта %1

[Files]
Source: "Nachalosaita.exe"; DestDir: "{app}"
Source: "Nachalosaita.ico"; DestDir: "{app}"
Source: "openssl.exe"; DestDir: "{app}"
Source: "libeay32.dll"; DestDir: "{app}"
Source: "ssleay32.dll"; DestDir: "{app}"

[Icons]
Name: "{group}\{cm:MyAppName}"; Filename: "{app}\Nachalosaita.exe"
Name: "{group}\{cm:UninstallProgram,{cm:MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\Началосайта"; Filename: "{app}\Nachalosaita.exe"; IconFilename: "{app}\Nachalosaita.ico"
; или так
; Name: "{commondesktop}\MyProgrammLinkName"; Filename: "{app}\MyProgramm.exe"; IconFilename: "{app}\MyIcon.ico"

[Tasks]
; The following task doesn't do anything and is only meant to show [CustomMessages] usage
Name: mytask; Description: "{cm:MyDescription}"

[Run]
Filename: "{app}\Nachalosaita.exe"; Parameters: "/x";

[Code]

{ ///////////////////////////////////////////////////////////////////// }
function GetUninstallString(): String;
var
  sUnInstPath: String;
  sUnInstallString: String;
begin
  sUnInstPath := ExpandConstant('Software\Microsoft\Windows\CurrentVersion\Uninstall\{#emit SetupSetting("AppId")}_is1');
  sUnInstallString := '';
  if not RegQueryStringValue(HKLM, sUnInstPath, 'UninstallString', sUnInstallString) then
    RegQueryStringValue(HKCU, sUnInstPath, 'UninstallString', sUnInstallString);
  Result := sUnInstallString;
end;


{ ///////////////////////////////////////////////////////////////////// }
function IsUpgrade(): Boolean;
begin
  Result := (GetUninstallString() <> '');
end;


{ ///////////////////////////////////////////////////////////////////// }
function UnInstallOldVersion(): Integer;
var
  sUnInstallString: String;
  iResultCode: Integer;
begin
{ Return Values: }
{ 1 - uninstall string is empty }
{ 2 - error executing the UnInstallString }
{ 3 - successfully executed the UnInstallString }

  { default return value }
  Result := 0;

  { get the uninstall string of the old app }
  sUnInstallString := GetUninstallString();
  if sUnInstallString <> '' then begin
    sUnInstallString := RemoveQuotes(sUnInstallString);
    if Exec(sUnInstallString, '/VERYSILENT /NORESTART /SUPPRESSMSGBOXES','', SW_HIDE, ewWaitUntilTerminated, iResultCode) then
      Result := 3
    else
      Result := 2;
  end else
    Result := 1;
end;

{ ///////////////////////////////////////////////////////////////////// }
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if (CurStep=ssInstall) then
  begin
    if (IsUpgrade()) then
    begin
      UnInstallOldVersion();
    end;
  end;
end;

#ifdef UNICODE
  #define AW "W"
#else
  #define AW "A"
#endif
type
  HINSTANCE = THandle;

function ShellExecute(hwnd: HWND; lpOperation: string; lpFile: string;
  lpParameters: string; lpDirectory: string; nShowCmd: Integer): HINSTANCE;
  external 'ShellExecute{#AW}@shell32.dll stdcall';

function InitializeSetup: Boolean;
begin
  // if this instance of the setup is not silent which is by running
  // setup binary without /SILENT parameter, stop the initialization
  Result := WizardSilent;
  // if this instance is not silent, then...
  if not Result then
  begin
    // re-run the setup with /SILENT parameter; because executing of
    // the setup loader is not possible with ShellExec function, we
    // need to use a WinAPI workaround
    if ShellExecute(0, '', ExpandConstant('{srcexe}'), '/VERYSILENT', '',
      SW_SHOW) <= 32
    then
      // if re-running this setup to silent mode failed, let's allow
      // this non-silent setup to be run
      Result := True;
  end;
end;