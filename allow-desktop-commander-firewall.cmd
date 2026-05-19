@echo off
setlocal

set "TOOL_VERSION=v1.0"
set "RULE_NAME=Desktop Commander"
set "PROGRAM_PATH=C:\Program Files\Desktop Commander\Desktop Commander.exe"

title Desktop Commander Diagnose Tool

echo.
echo ============================================================
echo  Desktop Commander Diagnose Tool
echo ============================================================
echo  Version %TOOL_VERSION%
echo.
echo This tool will add a Windows Firewall rule for Desktop Commander.
echo.
echo Rule name:    %RULE_NAME%
echo Program path: %PROGRAM_PATH%
echo Profiles:    Public, Domain
echo Direction:   Inbound
echo Action:      Allow
echo.

net session >nul 2>&1
if errorlevel 1 (
  echo ERROR: Administrator permission is required.
  echo.
  echo Please right-click this file and choose "Run as administrator",
  echo then run the diagnose tool again.
  echo.
  pause
  exit /b 1
)

choice /c YN /n /m "Do you want to continue and apply this firewall rule? [Y/N] "
if errorlevel 2 (
  echo.
  echo No changes were made.
  echo.
  pause
  exit /b 0
)

echo.
echo Applying firewall rule...
echo.

netsh.exe advfirewall firewall delete rule name="%RULE_NAME%" program="%PROGRAM_PATH%" >nul 2>&1

netsh.exe advfirewall firewall add rule ^
  enable=yes ^
  action=allow ^
  protocol=any ^
  profile=public,domain ^
  direction=in ^
  name="%RULE_NAME%" ^
  program="%PROGRAM_PATH%"

set "RESULT=%ERRORLEVEL%"
echo.

if "%RESULT%"=="0" (
  echo Success: Desktop Commander firewall access is now allowed.
) else (
  echo ERROR: Failed to add the Desktop Commander firewall rule.
  echo netsh.exe returned error code %RESULT%.
)

echo.
pause
exit /b %RESULT%
