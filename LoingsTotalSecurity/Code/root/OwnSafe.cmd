@(
	Cd /d "%~dp0"
	Call "%~dp0Modules\NormalRun.cmd"
	Call "%~dp0GetAdmin.dll.cmd" "%~0"
)
(
	SetLocal EnableDelayedExpansion
	Set LL=%time:~0,5%
	Echo.Loings Total Security - 自我防护模块
	Set "PGA=%Random%%Random%%Random%"
	Call "%~dp0Config.dll.cmd" Set.Color
)
Title %PGA%
For /f "eol=; tokens=2,3* delims=," %%a in (
		'Tasklist /v /fo csv /fi "IMAGENAME eq cmd.exe" ^| Find "%PGA%"'
	) do (
		Set "LTS.Run.Process.Id.OS=%%a"
)
Set "LTS.Run.Process.Id.OS=%LTS.Run.Process.Id.OS:~1,-1%"
Echo.Set "LTS.Run.Process.Id.OS=%LTS.Run.Process.Id.OS%">"Variable\Run.Info.3.bat"
Set "RONS=%RANDOM:~-1%"
Set /A "RONS1=%RONS%+1"

:Loop
(
	If not exist "%~dp0Registry\SafetyCenter\SelfProtect\True.cmd" Exit
	If exist "%~dp0Acl.Lock.dll.cmd" Call "%~dp0Acl.Lock.dll.cmd"
	If not "!sr!"=="T" If "!time:~4,1!"=="%RONS%" Goto :Update
	If "!time:~4,1!"=="%RONS1%" Set "sr="
	Timeout /t 2 >nul
	Goto :Loop
)

:Update
(
	Set "sr=T"
	Start /min Update.cmd Auto >nul 2>nul
	Goto :Loop
)
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS 全功能安全套装'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=7b4769d8e6e20ec669a6aa681c7c61f748e6107cab5011b1a5d3aaa74f5ae3f1'
Set LOINGS-SA_VerCode=c823f59b8910002db12d1aa3c3a7639a58d02f923355b6c2990f61edf63dde60'
