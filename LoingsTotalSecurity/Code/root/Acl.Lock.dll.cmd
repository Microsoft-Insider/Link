(
Cd /d "%~dp0"
Takeown /f "*.cmd" /r /d y >nul 2>nul
Echo.Y|Cacls "*.cmd" /c /g Administrators:R /t >nul 2>nul
)