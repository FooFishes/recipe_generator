; 使用 /dAppVersion=... 和 /dSourcePath=... 从命令行接收变量
#ifndef AppVersion
  #define AppVersion "0.0.0"  // 本地编译时的默认版本号
#endif
#ifndef SourcePath
  #define SourcePath "F:\Release" // 本地编译时的默认路径
#endif

#define MyAppName "食谱生成"
#define MyAppPublisher "UniLink"
#define MyAppExeName "recipe_generator.exe"
// 使用传入的版本号
#define MyAppVersion "{#AppVersion}" 

[Setup]
AppId={{5851B3F7-AAB2-4817-B4B8-350240566C65}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
UninstallDisplayIcon={app}\{#MyAppExeName}
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
PrivilegesRequired=lowest
; 将输出目录改为相对路径，CI环境会创建这个文件夹
OutputDir=output
; 将输出文件名与版本号关联
OutputBaseFilename="{#MyAppName}-{#MyAppVersion}-setup"
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "chinesesimplified"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; 使用传入的 SourcePath 变量来定位文件
Source: "{#SourcePath}\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourcePath}\other\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
