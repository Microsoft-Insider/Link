(
Cd /d "%~dp0" >nul 2>nul
Takeown /f "*.cmd" /r /d y >nul 2>nul
Icacls "*.cmd" /grant %username%:F /t >nul 2>nul
Icacls "*.cmd" /grant administrators:F /t >nul 2>nul
Attrib -R *.cmd /s >nul 2>nul
)