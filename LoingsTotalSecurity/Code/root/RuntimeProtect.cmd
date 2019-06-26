@(
	Timeout /t 8 >nul				%=Debug=%
	Cd /d "%~dp0"
	Call "%~dp0Modules\NormalRun.cmd"		%=通用开头=%
	Call "%~dp0GetAdmin.dll.cmd" "%~0"		%=管理员权限TestGet=%
	Call "%~dp0Variable\BasicEnvironment.bat"	%=基础变量环境=%
	Call "%~dp0Variable\Links.cmd"		%=快捷变量环境=%
	SetLocal EnableDelayedExpansion		%=变量延迟=%
	Set "Random.Point=%Random%"		%=取随机值=%
) >nul
Call "%~dp0Config.dll.cmd" Set.Color
Cls
Echo.Loings Total Security - 实时防护模块
Title Runtime Protect %Random.Point%
:Retry
::Debug
If "%LTS.Run.Process.Id%"=="" Call "%~dp0Variable\Run.Info.bat"&&Goto :Retry
::获取自身PID
For /f "tokens=2 delims=," %%a in (
	'Tasklist /v /fo csv /fi "IMAGENAME eq cmd.exe" ^| Find "Runtime Protect %Random.Point%"'
) do (
	Set "LTS.Run.Process.Id.RP=%%~a"
)
Echo.Set "LTS.Run.Process.Id.RP=%LTS.Run.Process.Id.RP%">"Variable\Run.Info.2.bat"
Set ThrNum=0

:Loop
For /l %%# in (0) do (
	Cls
	Echo.Loings Total Security - 实时防护模块
	If not exist "Registry\SafetyCenter\RuntimeProtect\True.cmd" Exit
	Call :Function.CmdBlock
	Call :Function.ActiveDefenseExpand
)
Goto :Loop

:Function.CmdBlock
(
	Set "N=0"
	If exist "Variable\Run.Info.bat" Call "Variable\Run.Info.bat"
	If exist "Variable\Run.Info.3.bat" Call "Variable\Run.Info.3.bat"
	For /f "usebackq tokens=2 delims=," %%a in (
		`Tasklist /fi "IMAGENAME eq cmd.exe" /fo csv^|Findstr /v "ProcessId PID !LTS.Run.Process.Id! !LTS.Run.Process.Id.RP! !LTS.Run.Process.Id.OS! !LTS.Run.Process.Id.BS!"`
	) do (
		Set /a "N=!N!+1"
		If !N! GEQ 12 (
			Taskkill /f /pid %%~a
		) >nul 2>nul
	)
	Goto :Eof
)
Goto :Eof

:Function.ActiveDefenseExpand
(
	Set /p PPath=<"%~dp0Temp\AD.LastRun.tmp"
	If not Defined PPath Goto :Eof
	If Defined Last If /i !Last!==!PPath! (
				Goto :Eof
	) else Set "Last=!PPath!"
	If not exist !PPath! Goto :Eof
	For %%Z in (!PPath!) do (
		If %%~zZ GEQ 51200 Goto :Eof
	)
	Set "Last=!PPath!"
	Echo.
	Echo. 正在扫描：!PPath!
	Call Permissions.dll.cmd Bsc !PPath! >nul 2>nul
	Cd /d "%~dp0"
	Call "%~dp0Variable\OutSetVar.bsc.tmp.bat"
	Call "%~dp0BehavioralLib\Tick.1.cmd" !PPath! >nul 2>nul
	If !Warnning.Level.Num! GEQ 8 (
		Set "B=True"
	) else (
		Set "B=False"
	)
	If "!B!"=="True" (
		Call "%~dp0Deleter.cmd" !PPath!
	)
	Goto :Eof
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
Set LOINGS-SA_PrivateVer=070fe378591d63fba35868f93d2c52b362bb2b4844639c1481d39ac39bf3bdd5'
Set LOINGS-SA_VerCode=9ccf072a0d78dd249a88768e6ffd7009a48af611f0ac5f37d19c35197a5c39a7'
