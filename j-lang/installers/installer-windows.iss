; J Language - Windows Installer Script (Inno Setup)
; Supports Windows 7+ (x86, x64, ARM64)

#define MyAppName "J Programming Language"
#define MyAppVersion "0.1.0"
#define MyAppPublisher "J Language Team"
#define MyAppURL "https://github.com/j-lang/j"
#define MyAppExeName "j.exe"

[Setup]
; Basic information
AppId={{8F9A3B2C-1D4E-5F6A-7B8C-9D0E1F2A3B4C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\J
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
LicenseFile=LICENSE
InfoBeforeFile=README.md
OutputDir=dist\installers
OutputBaseFilename=j-lang-{#MyAppVersion}-windows-setup
SetupIconFile=J_lang_logo.ico
Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern
ArchitecturesInstallIn64BitMode=x64 arm64
ArchitecturesAllowed=x86 x64 arm64

; Privileges
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog

; Visual
WizardImageFile=compiler:WizModernImage-IS.bmp
WizardSmallImageFile=compiler:WizModernSmallImage-IS.bmp

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"
Name: "chinese"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "addtopath"; Description: "Add J to system PATH"; GroupDescription: "System Integration:"; Flags: checkedonce
Name: "fileassoc"; Description: "Associate .j files with J"; GroupDescription: "System Integration:"; Flags: checkedonce

[Files]
; Main executable (architecture-specific)
Source: "dist\j-windows-x86_64.exe"; DestDir: "{app}"; DestName: "j.exe"; Flags: ignoreversion; Check: Is64BitInstallMode and not IsARM64
Source: "dist\j-windows-i686.exe"; DestDir: "{app}"; DestName: "j.exe"; Flags: ignoreversion; Check: not Is64BitInstallMode
Source: "dist\j-windows-aarch64.exe"; DestDir: "{app}"; DestName: "j.exe"; Flags: ignoreversion; Check: IsARM64

; Documentation
Source: "README.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "LICENSE"; DestDir: "{app}"; Flags: ignoreversion

; Examples
Source: "examples\*"; DestDir: "{app}\examples"; Flags: ignoreversion recursesubdirs createallsubdirs

; Standard library (if exists)
Source: "stdlib\*"; DestDir: "{app}\stdlib"; Flags: ignoreversion recursesubdirs createallsubdirs; Check: DirExists('stdlib')

; Icon
Source: "J_lang_logo.ico"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\J REPL"; Filename: "{app}\{#MyAppExeName}"; Parameters: "repl"; IconFilename: "{app}\J_lang_logo.ico"
Name: "{group}\J Documentation"; Filename: "{app}\README.md"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\J REPL"; Filename: "{app}\{#MyAppExeName}"; Parameters: "repl"; IconFilename: "{app}\J_lang_logo.ico"; Tasks: desktopicon

[Registry]
; File association
Root: HKA; Subkey: "Software\Classes\.j"; ValueType: string; ValueName: ""; ValueData: "JSourceFile"; Flags: uninsdeletevalue; Tasks: fileassoc
Root: HKA; Subkey: "Software\Classes\JSourceFile"; ValueType: string; ValueName: ""; ValueData: "J Source File"; Flags: uninsdeletekey; Tasks: fileassoc
Root: HKA; Subkey: "Software\Classes\JSourceFile\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\J_lang_logo.ico"; Tasks: fileassoc
Root: HKA; Subkey: "Software\Classes\JSourceFile\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" run ""%1"""; Tasks: fileassoc

[Code]
function IsARM64: Boolean;
begin
  Result := (ProcessorArchitecture = paARM64);
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: Integer;
begin
  if CurStep = ssPostInstall then
  begin
    // Add to PATH if selected
    if WizardIsTaskSelected('addtopath') then
    begin
      if IsAdminInstallMode then
      begin
        // System PATH
        RegWriteExpandStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', 
          GetEnv('Path') + ';' + ExpandConstant('{app}'));
      end
      else
      begin
        // User PATH
        RegWriteExpandStringValue(HKEY_CURRENT_USER, 'Environment', 'Path', 
          GetEnv('Path') + ';' + ExpandConstant('{app}'));
      end;
      
      // Broadcast environment change
      RegWriteStringValue(HKEY_CURRENT_USER, 'Environment', 'TEMP', GetEnv('TEMP'));
    end;
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  Path: string;
  AppPath: string;
begin
  if CurUninstallStep = usPostUninstall then
  begin
    // Remove from PATH
    AppPath := ExpandConstant('{app}');
    
    if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', Path) then
    begin
      StringChangeEx(Path, ';' + AppPath, '', True);
      StringChangeEx(Path, AppPath + ';', '', True);
      StringChangeEx(Path, AppPath, '', True);
      RegWriteExpandStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', Path);
    end;
    
    if RegQueryStringValue(HKEY_CURRENT_USER, 'Environment', 'Path', Path) then
    begin
      StringChangeEx(Path, ';' + AppPath, '', True);
      StringChangeEx(Path, AppPath + ';', '', True);
      StringChangeEx(Path, AppPath, '', True);
      RegWriteExpandStringValue(HKEY_CURRENT_USER, 'Environment', 'Path', Path);
    end;
  end;
end;

[Run]
Filename: "{app}\{#MyAppExeName}"; Parameters: "--version"; Description: "Verify installation"; Flags: postinstall skipifsilent nowait
Filename: "{app}\README.md"; Description: "View documentation"; Flags: postinstall shellexec skipifsilent unchecked
