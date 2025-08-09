@echo off
:: Batch script to add "Open with Code" to context menu with preview + confirm

:: Check for admin rights
fltmc >nul 2>&1 || (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process -Verb RunAs -FilePath '%~0'"
    exit /b
)

:: Detect VS Code path
set "vscode_path="
for %%d in (
    "%ProgramFiles%\Microsoft VS Code\Code.exe",
    "%LocalAppData%\Programs\Microsoft VS Code\Code.exe"
) do if exist "%%~d" set "vscode_path=%%~d"

if not defined vscode_path (
    echo Error: VS Code not found in:
    echo - "%ProgramFiles%\Microsoft VS Code\Code.exe"
    echo - "%LocalAppData%\Programs\Microsoft VS Code\Code.exe"
    pause
    exit /b 1
)

echo Found VS Code at: %vscode_path%

:: Generate .reg file
set "regfile=%temp%\OpenWithCode.reg"
(
    echo Windows Registry Editor Version 5.00
    echo;
    echo [-HKEY_CLASSES_ROOT\Directory\shell\OpenWithCode]
    echo [-HKEY_CLASSES_ROOT\Directory\Background\shell\OpenWithCode]
    echo [-HKEY_CLASSES_ROOT\*\shell\OpenWithCode]
    echo;
    echo [HKEY_CLASSES_ROOT\Directory\shell\OpenWithCode]
    echo @="Open with Code"
    echo "Icon"="\"%vscode_path:\=\\%\",0"
    echo;
    echo [HKEY_CLASSES_ROOT\Directory\shell\OpenWithCode\command]
    echo @="\"%vscode_path:\=\\%\" \"%%1\""
    echo;
    echo [HKEY_CLASSES_ROOT\Directory\Background\shell\OpenWithCode]
    echo @="Open with Code"
    echo "Icon"="\"%vscode_path:\=\\%\",0"
    echo;
    echo [HKEY_CLASSES_ROOT\Directory\Background\shell\OpenWithCode\command]
    echo @="\"%vscode_path:\=\\%\" \"%%V\""
    echo;
    echo [HKEY_CLASSES_ROOT\*\shell\OpenWithCode]
    echo @="Open with Code"
    echo "Icon"="\"%vscode_path:\=\\%\",0"
    echo;
    echo [HKEY_CLASSES_ROOT\*\shell\OpenWithCode\command]
    echo @="\"%vscode_path:\=\\%\" \"%%1\""
) > "%regfile%"

:: Preview in Notepad
echo Opening registry file for preview...
notepad "%regfile%"

:: Ask for confirmation
set /p "confirm=Apply these registry changes? (y/n): "
if /i not "%confirm%"=="y" (
    echo Cancelled. No changes made.
    pause
    exit /b
)

:: Apply changes
regedit /s "%regfile%"

:: Restart File Explorer
taskkill /f /im explorer.exe >nul
start explorer.exe

echo Success! "Open with Code" added to context menu.
pause
