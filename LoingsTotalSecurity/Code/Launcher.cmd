@(
Echo off
Color F3
Cd /d "%~dp0"
Mode con cols=51 lines=8
Title Loings Total Security
SetLocal EnableDelayedExpansion
Cls
Echo.
Echo.
Echo.
Echo.               Loings Total Security
Echo.
Echo.
Echo.
Call :GetAdmin
Call "%~dp0root\Config.dll.cmd" Set.Color
Del /f /q "%~dp0root\Temp\run.tmp" >nul 2>nul
Start /min /high "" "%~dp0root\Runner.cmd"
)
(
Set "Shows=                        -"
Call :Mode
Set "Shows=                       ---"
Call :Mode
Set "Shows=                      -----"
Call :Mode
Set "Shows=                     -------"
Call :Mode
Set "Shows=                    ---- ----"
Set "N=0"
)
:RS1
(
Set "Shows=!Shows:~1,24!  !Shows:~25,25!"
If "!N!"=="24" Goto :Wait
Call :Mode
If exist "%~dp0root\Temp\run.tmp" Exit
Set /a "N+=1"
Goto :RS1
)
:Mode
(
Cls&Echo.&Echo.&Echo.
Echo.               Loings Total Security
Echo.&Echo.!Shows!
Goto :Eof
)
:Wait
(
Cls
Echo.
Echo.
Echo.
Echo.               Loings Total Security
Echo.
Echo.
Echo.
Set T=0
)
:Wait2
(
If "%T%"=="60" Goto Wait3
Set /a T+=1
If exist "%~dp0root\Temp\run.tmp" Exit
Timeout /t 1 /nobreak >nul 2>nul
Goto :Wait2
)
:Wait3
Exit

:GetAdmin
Reg query "HKU\S-1-5-19" >nul 2>nul|| (
	Del "LTS.VBS" >nul 2>nul
	Echo Set UAC = CreateObject^("Shell.Application"^) > "LTS.VBS"
	Echo UAC.ShellExecute "%~f0", "", "", "runas", 1 >> "LTS.VBS"
	"LTS.VBS"
	Del "LTS.VBS" >nul 2>nul
	Exit
)
Goto :Eof
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS 全功能安全套装'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=50ef49c53cd75206914cd029eb8d9e34b6b1b20f298df530abdb2b7f66a5b216'
Set LOINGS-SA_VerCode=685670d37881ffc10201a64db79ea508095d3af89a09b3fb020ea3a1e510d50d'
