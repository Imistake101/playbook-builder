@echo off
setlocal EnableDelayedExpansion

REM ========================================
REM Build playbook from src folder
REM ========================================

echo [*] Building playbook...

REM Change to the script directory to be safe
pushd "%~dp0"

REM Check if PowerShell is available
where powershell >nul 2>&1
if errorlevel 1 (
    echo [!] PowerShell is not available. Aborting.
    popd
    pause
    exit /b 1
)

REM Clean previous builds
echo [*] Cleaning old build artifacts...
del /f /q playbook.zip >nul 2>&1
del /f /q playbook.apbx >nul 2>&1

REM Ensure src folder exists
if not exist ".\src\" (
    echo [!] 'src' folder not found. Nothing to build.
    popd
    pause
    exit /b 1
)

REM Create ZIP archive from the src folder
echo [*] Compressing src folder...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Compress-Archive -Path '.\src\*' -DestinationPath '.\playbook.zip' -Force"

if errorlevel 1 (
    echo [!] Build failed during compression!
    popd
    pause
    exit /b 1
)

REM Rename ZIP to APBX format
echo [*] Renaming to playbook.apbx...
ren playbook.zip playbook.apbx

REM Confirm success
if exist playbook.apbx (
    echo [+] Build succeeded! Created: playbook.apbx
) else (
    echo [!] Unexpected error: .apbx file not found after rename.
    popd
    pause
    exit /b 1
)

popd
pause
endlocal