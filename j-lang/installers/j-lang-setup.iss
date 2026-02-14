; J Language - Inno Setup Installer Script
; Creates a professional Windows installer with GUI

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
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\J
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
OutputDir=..\dist\installers
OutputBaseFilename=j-lang-{#MyAppVersion}-windows-setup
SetupIconFile=..\J_lang_logo.ico
Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern
ArchitecturesInstallIn64BitMode=x64compatible
ArchitecturesAllowed=x86 x64compatible arm64

; Privileges
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog

; Visual
WizardImageFile=compiler:WizModernImage-IS.bmp
WizardSmallImageFile=compiler:WizModernSmallImage-IS.bmp

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "addtopath"; Description: "Add J to system PATH (recommended)"; GroupDescription: "System Integration:"; Flags: checkedonce
Name: "fileassoc"; Description: "Associate .j files with J"; GroupDescription: "System Integration:"; Flags: checkedonce

[Files]
; Main executable - try multiple locations
Source: "..\dist\j-windows-x86_64.exe"; DestDir: "{app}"; DestName: "j.exe"; Flags: ignoreversion; Check: Is64BitInstallMode
Source: "..\dist\j-windows-i686.exe"; DestDir: "{app}"; DestName: "j.exe"; Flags: ignoreversion; Check: not Is64BitInstallMode
Source: "..\target\release\j.exe"; DestDir: "{app}"; Flags: ignoreversion; Check: not FileExists(ExpandConstant('{app}\j.exe'))

; Examples
Source: "..\examples\*"; DestDir: "{app}\examples"; Flags: ignoreversion recursesubdirs createallsubdirs

; Icon
Source: "..\J_lang_logo.ico"; DestDir: "{app}"; Flags: ignoreversion

; Documentation
Source: "..\README.md"; DestDir: "{app}"; Flags: ignoreversion isreadme
Source: "..\..\README.md"; DestDir: "{app}"; Flags: ignoreversion; Check: not FileExists(ExpandConstant('{app}\README.md'))

[Icons]
Name: "{group}\J REPL"; Filename: "{app}\{#MyAppExeName}"; Parameters: "repl"; IconFilename: "{app}\J_lang_logo.ico"
Name: "{group}\J Documentation"; Filename: "{app}\README.md"
Name: "{group}\Examples"; Filename: "{app}\examples"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\J REPL"; Filename: "{app}\{#MyAppExeName}"; Parameters: "repl"; IconFilename: "{app}\J_lang_logo.ico"; Tasks: desktopicon

[Registry]
; File association
Root: HKA; Subkey: "Software\Classes\.j"; ValueType: string; ValueName: ""; ValueData: "JSourceFile"; Flags: uninsdeletevalue; Tasks: fileassoc
Root: HKA; Subkey: "Software\Classes\JSourceFile"; ValueType: string; ValueName: ""; ValueData: "J Source File"; Flags: uninsdeletekey; Tasks: fileassoc
Root: HKA; Subkey: "Software\Classes\JSourceFile\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\J_lang_logo.ico"; Tasks: fileassoc
Root: HKA; Subkey: "Software\Classes\JSourceFile\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" run ""%1"""; Tasks: fileassoc
Root: HKA; Subkey: "Software\Classes\JSourceFile\shell\edit"; ValueType: string; ValueName: ""; ValueData: "Edit with Notepad"; Tasks: fileassoc
Root: HKA; Subkey: "Software\Classes\JSourceFile\shell\edit\command"; ValueType: string; ValueName: ""; ValueData: "notepad.exe ""%1"""; Tasks: fileassoc

[Code]
var
  PathModified: Boolean;

procedure AddToPath();
var
  OldPath, NewPath, AppPath: string;
  PathArr: TArrayOfString;
  i: Integer;
  Found: Boolean;
begin
  AppPath := ExpandConstant('{app}');
  
  if IsAdminInstallMode then
  begin
    // System PATH
    if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', OldPath) then
    begin
      // Check if already in path
      Found := False;
      PathArr := SplitString(OldPath, ';');
      for i := 0 to GetArrayLength(PathArr) - 1 do
      begin
        if CompareText(PathArr[i], AppPath) = 0 then
        begin
          Found := True;
          Break;
        end;
      end;
      
      if not Found then
      begin
        NewPath := OldPath;
        if Length(NewPath) > 0 then
          NewPath := NewPath + ';';
        NewPath := NewPath + AppPath;
        
        if RegWriteExpandStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', NewPath) then
          PathModified := True;
      end;
    end;
  end
  else
  begin
    // User PATH
    if RegQueryStringValue(HKEY_CURRENT_USER, 'Environment', 'Path', OldPath) then
    begin
      // Check if already in path
      Found := False;
      PathArr := SplitString(OldPath, ';');
      for i := 0 to GetArrayLength(PathArr) - 1 do
      begin
        if CompareText(PathArr[i], AppPath) = 0 then
        begin
          Found := True;
          Break;
        end;
      end;
      
      if not Found then
      begin
        NewPath := OldPath;
        if Length(NewPath) > 0 then
          NewPath := NewPath + ';';
        NewPath := NewPath + AppPath;
        
        if RegWriteExpandStringValue(HKEY_CURRENT_USER, 'Environment', 'Path', NewPath) then
          PathModified := True;
      end;
    end
    else
    begin
      // Create new PATH
      if RegWriteExpandStringValue(HKEY_CURRENT_USER, 'Environment', 'Path', AppPath) then
        PathModified := True;
    end;
  end;
end;

procedure RemoveFromPath();
var
  OldPath, NewPath, AppPath: string;
  PathArr: TArrayOfString;
  i: Integer;
begin
  AppPath := ExpandConstant('{app}');
  
  if IsAdminInstallMode then
  begin
    if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', OldPath) then
    begin
      NewPath := '';
      PathArr := SplitString(OldPath, ';');
      for i := 0 to GetArrayLength(PathArr) - 1 do
      begin
        if CompareText(PathArr[i], AppPath) <> 0 then
        begin
          if Length(NewPath) > 0 then
            NewPath := NewPath + ';';
          NewPath := NewPath + PathArr[i];
        end;
      end;
      RegWriteExpandStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', NewPath);
    end;
  end
  else
  begin
    if RegQueryStringValue(HKEY_CURRENT_USER, 'Environment', 'Path', OldPath) then
    begin
      NewPath := '';
      PathArr := SplitString(OldPath, ';');
      for i := 0 to GetArrayLength(PathArr) - 1 do
      begin
        if CompareText(PathArr[i], AppPath) <> 0 then
        begin
          if Length(NewPath) > 0 then
            NewPath := NewPath + ';';
          NewPath := NewPath + PathArr[i];
        end;
      end;
      RegWriteExpandStringValue(HKEY_CURRENT_USER, 'Environment', 'Path', NewPath);
    end;
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    PathModified := False;
    
    if WizardIsTaskSelected('addtopath') then
    begin
      AddToPath();
    end;
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usPostUninstall then
  begin
    RemoveFromPath();
  end;
end;

function InitializeSetup(): Boolean;
begin
  Result := True;
end;

procedure DeinitializeSetup();
begin
  if PathModified then
  begin
    // Notify system of environment change
    SendBroadcastMessage(WM_SETTINGCHANGE, 0, CastStringToInteger('Environment'));
  end;
end;

[Run]
Filename: "{app}\{#MyAppExeName}"; Parameters: "--version"; Description: "Verify installation"; Flags: postinstall skipifsilent nowait runhidden
Filename: "{app}\README.md"; Description: "View documentation"; Flags: postinstall shellexec skipifsilent unchecked

[UninstallDelete]
Type: filesandordirs; Name: "{app}"
