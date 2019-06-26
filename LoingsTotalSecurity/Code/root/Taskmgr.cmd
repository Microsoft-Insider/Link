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


	Create	����һ�����������
		Taskmgr Create ������·��(Path)

	Getall	��ȡһ�����̵���ϸ��Ϣ
		Taskmgr Getall ���̱�ʶ(PID)

	Getlist	��ȡ����������б�
		Taskmgr Getlist [ Normal | Path | Pid]
			Normal	��������ʾһ����CommandLine,Name,ProcessId
			Path	��ȡ���кϸ��������·��
			Pid	��ȡ������������̵Ľ��̱�ʶ

	Kill	ǿ�ƽ�������
		Taskmgr Kill ���̱�ʶ(PID)

	Open	���ļ�λ��
		Taskmgr Open ���̱�ʶ(PID)

End

:List
Cls
Echo.%Date:~0,10% %Time:~0,-3%          cmd.exe          %Computername%\%Username%
Wmic process where name="cmd.exe" get CommandLine,Name,ProcessId
Echo./Create Path  ��������   /Kill PID  ��������   /Getall PID  ��ȡ��ϸ��Ϣ   /Open PID  ���ļ�λ��
Echo.
Set Do=
Set /p Do=���룺
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
	Echo.δ����ָ�����̡�
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
Echo.���ṩ��ϸ������
Goto :Eof

:Kill
Tasklist | Find "%~1" >nul 2>nul || (
	Echo.δ����ָ�����̡�
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
	Echo.�޷���ȡ�ý���·����
	Timeout /t 3 >nul 2>nul
	Goto :Eof
)
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=���������'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=5c96061bfe9a967ebcdb74ef61422ad1fba741504bdfeab95830db22e41e722a'
Set LOINGS-SA_VerCode=2af7d4dae8b45bcfd2c1eb76f87ca0e215020fd368dbd6d51708111f0d96fd59'
