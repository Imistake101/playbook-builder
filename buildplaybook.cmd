@echo off
setlocal EnableDelayedExpansion

REM ========================================
REM Build playbook from src folder
REM ========================================

echo [*] Starting playbook build...

REM Change to the directory of this script
pushd "%~dp0" >nul

REM Check for PowerShell
where powershell >nul 2>&1
if errorlevel 1 (
    echo [!] PowerShell is not available. Aborting.
    goto :cleanup
)

REM Clean previous build artifacts
echo [*] Cleaning previous build artifacts...
for %%F in (playbook.zip playbook.apbx) do (
    if exist "%%F" del /f /q "%%F" >nul 2>&1
)

REM Check for src folder
if not exist ".\src\" (
    echo [!] 'src' folder not found. Nothing to build.
    goto :cleanup
)

REM Compress src folder into ZIP
echo [*] Compressing 'src' folder into playbook.zip...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Compress-Archive -Path '.\src\*' -DestinationPath '.\playbook.zip' -Force"

if errorlevel 1 (
    echo [!] Compression failed. Aborting build.
    goto :cleanup
)

REM Rename ZIP to APBX
echo [*] Renaming ZIP to playbook.apbx...
ren playbook.zip playbook.apbx

REM Check final result
if exist playbook.apbx (
    echo [+] Build succeeded! Output: playbook.apbx
) else (
    echo [!] Build failed: playbook.apbx not found after renaming.
)

:cleanup
popd >nul
pause
endlocal
