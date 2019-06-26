@(
	Echo off
	SetLocal EnableDelayedExpansion
	If "%~1"=="" (
		Color F3
		Title Command Taskmgr
		Mode con cols=120 lines=30
		Cd /d "%~dp0"
		Cls
		Goto :List
	)
	If not "%~1"=="" (
		Call :%*
		Goto :Eof
	)
)
Goto :Eof

Taskmgr API:

	Taskmgr [ Create | Getall | Getlist | Kill | Open ] [ More... ]


	Create	创建一个批处理进程
		Taskmgr Create 批处理路径(Path)

	Getall	获取一个进程的详细信息
		Taskmgr Getall 进程标识(PID)

	Getlist	获取批处理进程列表
		Taskmgr Getlist [ Normal | Path | Pid]
			Normal	如正常显示一样，CommandLine,Name,ProcessId
			Path	获取所有合格的批处理路径
			Pid	获取所有批处理进程的进程标识

	Kill	强制结束进程
		Taskmgr Kill 进程标识(PID)

	Open	打开文件位置
		Taskmgr Open 进程标识(PID)

End

:List
Cls
Echo.%Date:~0,10% %Time:~0,-3%          cmd.exe          %Computername%\%Username%
Wmic process where name="cmd.exe" get CommandLine,Name,ProcessId
Echo./Create Path  创建进程   /Kill PID  结束进程   /Getall PID  获取详细信息   /Open PID  打开文件位置
Echo.
Set Do=
Set /p Do=输入：
If "%Do%"=="" Goto :List
(
	If /i "%Do:~0,8%"=="/Create " Call :Create %Do:~8%
	If /i "%Do:~0,8%"=="/Getall " Call :Getall %Do:~8%
	If /i "%Do:~0,6%"=="/Kill " Call :Kill %Do:~6%
	If /i "%Do:~0,6%"=="/Open " Call :Open %Do:~6%
	Goto :List
)

:Create
If exist "%~1" (
	For %%a in (cmd bat) do (
		If /i "%~x1"=="%%a" (
			Wmic process call create "%Windir%\system32\cmd.exe /c Call %1"
			Timeout /t 3 >nul 2>nul
		)
	)
)
Goto :Eof

:Getall
Tasklist | Find "%~1" >nul 2>nul || (
	Echo.未发现指定进程。
	Timeout /t 3 >nul 2>nul
	Goto :Eof
)
(
	Set "Get=Wmic process where "
	Tasklist /Fi "PID eq %~1" /v /fo list
	Echo.
)
%Get%(processid=%~1) get CSName,CommandLine,ExecutionState
%Get%(processid=%~1) get ParentProcessId,ProcessId,ReadOperationCount,ReadTransferCount
%Get%(processid=%~1) get SessionId,WriteOperationCount,WriteTransferCount
Pause >Nul
Goto :Eof

:Getlist
If /i "%~1"=="Normal" (
	Wmic process where name="cmd.exe" get CommandLine,Name,ProcessId
	Goto :Eof
)
If /i "%~1"=="Path" (
	Set "GPath=1"
	Wmic process where name="cmd.exe" get Name,ProcessId | (
		Findstr "cmd.exe" >"%~dp0Path.txt"
	)
	For /f "usebackq tokens=1*" %%a in ("%~dp0Path.txt") do (
		Call :Open %%b
		Echo.!Run.Path.Program!
	)
	Del /q "%~dp0Path.txt" >nul 2>nul
	Set "GPath="
	Goto :Eof
)
If /i "%~1"=="Pid" (
	Wmic process where name="cmd.exe" get ProcessId
	Goto :Eof
)
Echo.请提供详细参数。
Goto :Eof

:Kill
Tasklist | Find "%~1" >nul 2>nul || (
	Echo.未发现指定进程。
	Timeout /t 3 >nul 2>nul
	Goto :Eof
)
(
	Taskkill /f /pid "%~1"
	Timeout /t 3 >nul 2>nul
	Goto :Eof
)

:Open
Wmic process where (processid=%~1) get CommandLine | (
	Findstr "cmd.exe" >"%~dp0Path.txt"
)
Find /i "Call" "%~dp0Path.txt">nul 2>nul&&Goto :Next
For /f "usebackq tokens=1,2,3*" %%a in ("%~dp0Path.txt") do (
	Set "Run.Path.Program.tmp=%%c %%d"
)
Set "Run.Path.Program.tmp=%Run.Path.Program.tmp:"=%"
Call :GetPath "%Run.Path.Program.tmp%"
Del /f /q "%~dp0Path.txt" >nul 2>nul
Goto :NR
:GetPath
(
	Set "Run.Path.Program=%~f1"
	Set "program_name=%~nx1"
	Set "program_path=%~dp1"
	Set Run.Path.Program.tmp=
	Goto :Eof
)
:NR
(
	If "%Run.Path.Program%"==" " Goto :Next
	If not exist "%Run.Path.Program%" Goto :Next
	If "%GPath%"=="" Start "" "%program_path%"
)
Goto :Eof
:Next
(
	Echo.无法获取该进程路径。
	Timeout /t 3 >nul 2>nul
	Goto :Eof
)
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=任务管理器'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=5c96061bfe9a967ebcdb74ef61422ad1fba741504bdfeab95830db22e41e722a'
Set LOINGS-SA_VerCode=2af7d4dae8b45bcfd2c1eb76f87ca0e215020fd368dbd6d51708111f0d96fd59'
