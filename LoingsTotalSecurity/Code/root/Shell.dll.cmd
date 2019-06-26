@(
Echo off
If not exist "%~f1" Goto :Eof
Set RunShellVerCode=
Set "NameBu=%~nx1"
Set "PathBu=%~dp1"
Set "C=0"
Set "CrssShell=%Random%%Random%"
Setlocal enabledelayedexpansion
)

:ShellCmd_1
Set "PathBusT=%~dp0Temp\decode.!C!.bat"
Del /f /q "%~dp0Temp\decode.!C!.bat" "%~dp0Temp\decode.!C!.*.bat" >nul 2>nul
Certutil -decode "%~f1" "%~dp0Temp\decode.!C!.bat" >nul 2>nul || Set "PathBusT=%~f1"
Set "PathBus=!PathBusT!"
Call :PathGet "!PathBus!"
Goto :ShellCmd_2

:PathGet
Set "DPN.Path=%~dpn1"
Goto :Eof

:ShellCmd_2
Call "%~dp0Shell.CDE.dll.cmd" "!PathBus!" >nul
For /l %%a in (999,-1,1) do If exist "!DPN.Path!.%%a.bat" Set "OP=!DPN.Path!.%%a.bat"

:ShellCmd_3
Del "%~dp0Temp\decrypt_temp.txt" "%~dp0Temp\decrypt_set.bat" "%~dp0Temp\decrypt_code.tmp" "%~dp0Temp\decrypt_code_end.tmp" >nul 2>nul
Call :ShellCmd_3_O "%OP%"
Goto :ShellCmd_4
:ShellCmd_3_O
Set Change_Line=^


Set /a N=0
For /f "usebackq delims=" %%i in ("%~1") do (
	Set Str_Change_Line=%%i
	For %%l in ("!Change_Line!") do (
		(
			Set Str_Change_Line=!Str_Change_Line:^&=%%~l!
			Set Str_Change_Line=!Str_Change_Line:^|=%%~l!
			Set Str_Change_Line=!Str_Change_Line:^'='%%~l!
			Set Str_Change_Line=!Str_Change_Line:^`=`%%~l!
			Set Str_Change_Line=!Str_Change_Line:^"=!
			Set Str_Change_Line=!Str_Change_Line:^@=!
			Set Str_Change_Line=!Str_Change_Line:^^=#_$RS_#!
			Set Str_Change_Line=!Str_Change_Line:^<=#_$IN_#!
			Set Str_Change_Line=!Str_Change_Line:^>=#_$OU_#!
			Set Str_Change_Line=!Str_Change_Line:^(=#_$LQ_#!
			Set Str_Change_Line=!Str_Change_Line:^)=#_$RQ_#!
			Set Str_Change_Line=!Str_Change_Line:%%0=%%1!
			Set Str_Change_Line=!Str_Change_Line:%%~0=%%~1!
		)
		Set /a "N+=1"
		Set "Str_!N!=!Str_Change_Line!"
	)
)
For /l %%a in (1,1,!N!) do (
	Echo.!Str_%%a!>>"%~dp0Temp\decrypt_temp.txt"
)

Echo.::Loings Shell>"%~dp0Temp\decrypt_set.bat
Findstr /i "^Set.." "%~dp0Temp\decrypt_temp.txt" | Find "=" | Findstr /v /i "& | > < ) ( /p" >>"%~dp0Temp\decrypt_set.bat" 2>nul
If exist "%~dp0Temp\decrypt_set.bat" Call "%~dp0Temp\decrypt_set.bat"
For /f "usebackq delims=" %%a in ("%~dp0Temp\decrypt_temp.txt") do (
	Call :Bat_Decrypt_Key "%%a"
)
(
	If "%OP%"=="" Goto :Eof
	Del /f /q "%OP%" >nul 2>nul
	Goto :Eof
)

:Bat_Decrypt_Key
(
	Set "SCL=%*"
	Set "SCL=!SCL:#_$LQ_#=(!"
	Set "SCL=!SCL:#_$RQ_#=)!"
	Set "SCL=!SCL:#_$IN_#=<!"
	Set "SCL=!SCL:#_$OU_#=>!"
	Set "SCL=!SCL:#_$RS_#=^!"
	Echo.!SCL!>>"%~dp0Temp\decrypt_code.tmp"
	Goto :Eof
)
Goto :Eof

:ShellCmd_4
:Eof