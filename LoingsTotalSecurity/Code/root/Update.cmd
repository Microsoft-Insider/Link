@(
	Echo off
	Cd /d "%~dp0"
	Set "RAR=Modules\Rar.exe x -y -mt2"			%=WinRAR_Path=%
	Set "SelfVer=4"					%=Self_Version=%
	Set "GKW=%~1"
	SetLocal EnableDelayedExpansion
	If exist "%~dp0Variable\Run.Info.3.bat" Call "%~dp0Variable\Run.Info.3.bat"
)
Set "LSN="&Set "PSN="
Taskkill /f /pid %LTS.Run.Process.Id.OS% >nul 2>nul
If exist "%~dp0Acl.Unlock.dll.cmd" Call "%~dp0Acl.Unlock.dll.cmd" >nul 2>nul
Del /q "*Up.rar" >nul 2>nul
If /i "%~1"=="User" Goto :User
:First
::��ȡ�������ϵ���Ϣ
(
	Del /q ""%~dp0LTSVer.cmd" >nul 2>nul
	Call "%~dp0Download.dll.cmd" Server LTSVer.cmd "%~dp0LTSVer.cmd"
	If eixst "%~dp0LTSVer.cmd" (
		Call "%~dp0LTSVer.cmd"
	) else Goto :Err_1
	If eixst "%~dp0Modules\LibVer.cmd" Call "%~dp0Modules\LibVer.cmd"	%=���ذ汾=%
	If eixst "%~dp0Modules\ProVer.cmd" Call "%~dp0Modules\ProVer.cmd"	%=���ذ汾=%
)
Goto :%GKW%

:Auto
Set "min=/min"
Call :Update
Start /i /low /min "Loings Total Security !Random!" %Windir%\system32\cmd.exe /d /c Call "%~dp0OwnSafe.cmd"
Exit

:Update
If "%Force1%"=="0" (						%=�ж��Ƿ����=%
	If !ServerVersionBuild! LEQ !LocalVersionBuild! (
		If !UpSelfVer! LEQ !SelfVer! (
			Goto :Eof
		) else Set "PSN=1"
	)
)
::��ʼ����
:UpCon
For /f "usebackq tokens=1,2* delims==;" %%a in (`Set Update.%LocalVersionBuild%toNew`) do (
	If /i "%%~b"=="Del" Del /f /q "%~dp0%%~c"
	If /i "%%~b"=="Rd" Rd /s /q "%~dp0%%~c"
	If /i "%%~b"=="Same" (
		If not "!LocalVersionBuild!"=="%%~c" (
			Set "LocalVersionBuild=%%~c"
			Goto :Program
		)
	)
	If /i "%%~b"=="Self" (
		If !UpSelfVer! GTR !SelfVer! (
			Goto :Self
		)
	)
	If /i "%%~b"=="Server" (
		Call Download.dll.cmd  %%b "%%~c" "%~dp0%%~c"
		If "%%~xc"==".rar" (
			%RAR% "%~dp0%%~c" "%~dp0"
		)
	)
	If /i "%%~b"=="Code" (
		Call Download.dll.cmd  %%b "%%~c" "..\%%~c"
		If "%%~xc"==".rar" (
			%RAR% "..\%%~c" ..\
		)
	)
) >nul 2>nul
Set "min="
If "%Force2%"=="0" (						%=�ж��Ƿ����=%
	If !ServerLibraryVer! LEQ !LocalLibraryVer! (
		Call Download.dll.cmd Code "root\Library\Lib.SHA256_1.vsh" "%~dp0Library\Lib.SHA256_1.vsh"
		Call Download.dll.cmd Code "root\BehavioralLib\Tick.1.cmd" "%~dp0BehavioralLib\Tick.1.cmd"
		Call Download.dll.cmd Code "root\Modules\LibVer.cmd" "%~dp0BehavioralLib\LibVer.cmd"
	) else Set "LSN=1"
)
Goto :Eof

:Self
(
	Call Download.dll.cmd Server UpdateSelf.rar "%~dp0UpdateSelf.rar"
	%RAR% "%~dp0UpdateSelf.rar" "%~dp0"
	Del /f /q "%~dp0UpdateSelf.rar"
	Start !min! "" "%~f0" UpCon
	Exit
) >nul 2>nul
Exit

:RunLink
Start "" "%SLO%"			%=�����ѷ����汾�򿪹�������=%
Exit

:User
Call "Modules\NormalRun.cmd"
Call "%~dp0Config.dll.cmd" Set.Color
Title Loings Total Security
(
Cls
Echo.  Loings Total Security          ����
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.
Echo.        ���ڼ�����...
Echo.
)
(
	Del /q ""%~dp0LTSVer.cmd" >nul 2>nul
	Call "%~dp0Download.dll.cmd" Server LTSVer.cmd "%~dp0LTSVer.cmd"
	If eixst "%~dp0LTSVer.cmd" (
		Call "%~dp0LTSVer.cmd"
	) else Goto :Err_1
	If eixst "%~dp0Modules\LibVer.cmd" Call "%~dp0Modules\LibVer.cmd"	%=���ذ汾=%
	If eixst "%~dp0Modules\ProVer.cmd" Call "%~dp0Modules\ProVer.cmd"	%=���ذ汾=%
)
If "%Force%"=="0" (						%=�ж��Ƿ����=%
	If !ServerVersionBuild! LEQ !LocalVersionBuild! (
		If !ServerLibraryVer! LEQ !LocalLibraryVer! (
			If !UpSelfVer! LEQ !SelfVer! (
				Set "PDN=0"
			) else Set "PDN=1"
		)
	)
)
If "!PDN!"=="0" Goto :U_N
(
Cls
Echo.  Loings Total Security          ����
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.
Echo.        ���ڸ���...
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
)
Call :Update
:U_F
(
Cls
Echo.  Loings Total Security          ����
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.
Echo.        ��������ɡ�
Echo.
Start /i /low /min "Loings Total Security %Random%" %Windir%\system32\cmd.exe /d /c Call "%~dp0OwnSafe.cmd"
Timeout /t 3 >nul
Exit
)
:U_N
(
Cls
Echo.  Loings Total Security          ����
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.
Echo.        ��ĳ��������µġ�
Echo.
Start /i /low /min "Loings Total Security %Random%" %Windir%\system32\cmd.exe /d /c Call "%~dp0OwnSafe.cmd"
Timeout /t 3 >nul
Exit
)
:Err_1
(
Echo.        δ�ɹ���ȡ������Ϣ��
Start /i /low /min "Loings Total Security %Random%" %Windir%\system32\cmd.exe /d /c Call "%~dp0OwnSafe.cmd"
Exit
)
