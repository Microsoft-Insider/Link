@(
	Echo off
	Cd /d "%~dp0"
	Set "RAR=Modules\Rar.exe x -y -mt2"			%=WinRAR_Path=%
	Set "SelfVer=4"					%=Self_Version=%
	Set "GKW=%~1"
	Set "SaveFolder=%~dp0Temp\NewVer"
	SetLocal EnableDelayedExpansion
	If exist "%~dp0Variable\Run.Info.3.bat" Call "%~dp0Variable\Run.Info.3.bat"
)
Set "LSN="&Set "PSN="
Taskkill /f /pid %LTS.Run.Process.Id.OS% >nul 2>nul
If exist "%~dp0Acl.Unlock.dll.cmd" Call "%~dp0Acl.Unlock.dll.cmd" >nul 2>nul
Del /q "*Up.rar" >nul 2>nul
If /i "%~1"=="User" Goto :User
:First
::获取服务器上的信息
(
	Del /q "%~dp0LTSVer.cmd" >nul 2>nul
	Call "%~dp0Download.dll.cmd" Server LTSVer.cmd "%~dp0LTSVer.cmd"
	If exist "%~dp0LTSVer.cmd" (
		Call "%~dp0LTSVer.cmd"
	) else Goto :Err_1
	Set "LocalLibraryVer=19062701"
	If exist "%~dp0Modules\LibVer.cmd" Call "%~dp0Modules\LibVer.cmd"	%=本地版本=%
	If exist "%~dp0Modules\ProVer.cmd" Call "%~dp0Modules\ProVer.cmd"	%=本地版本=%
) >nul 2>nul
Goto :%GKW%

:Auto
Set "min=/min"
Call :Update
Start /i /low /min "Loings Total Security !Random!" %Windir%\system32\cmd.exe /d /c Call "%~dp0OwnSafe.cmd"
Exit

:Update
Echo.Update
If "%Force1%"=="0" (						%=判断是否更新=%
	If !ServerVersionBuild! LEQ !LocalVersionBuild! (
		If !UpSelfVer! LEQ !SelfVer! (
			Goto :Eof
		) else Set "PSN=1"
	)
)
Rd /s /q "!SaveFolder!\" >nul 2>nul
For %%a in (BehavioralLib,Library,Modules,Tools) do (
	Md "!SaveFolder!\root\%%a"
) >nul 2>nul

::开始更新
:UpCon
For /f "usebackq tokens=1,2,3* delims==;" %%a in (`Set Update.%LocalVersionBuild%toNew`) do (
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
		Call Download.dll.cmd  %%b "%%~c" "!SaveFolder!\root\%%~d"
		If "%%~xc"==".rar" (
			%RAR% "!SaveFolder!\root\%%~d" "%~dp0"
			Del /f /q "!SaveFolder!\root\%%~d"
		)
	)
	If /i "%%~b"=="Code" (
		Call Download.dll.cmd  %%b "%%~c" "%~dp0Temp\NewVer\%%~d"
		If "%%~xc"==".rar" (
			%RAR% "!SaveFolder!\%%~d" ..\
			Del /f /q "!SaveFolder!\%%~d"
		)
	)
) >nul 2>nul
Set "min="
If "%Force2%"=="0" (						%=判断是否更新=%
	If !ServerLibraryVer! LEQ !LocalLibraryVer! (
		Ren "%~dp0Library\Lib.SHA256_1.vsh"
		Call Download.dll.cmd Code "root/Library/Lib.SHA256_1.vsh""!SaveFolder!\root\Library\Lib.SHA256_1.vsh"
		Call Download.dll.cmd Code "root/BehavioralLib/Tick.1.cmd" "!SaveFolder!\root\BehavioralLib\Tick.1.cmd"
		Call Download.dll.cmd Code "root/Modules/LibVer.cmd" "!SaveFolder!\root\Modules\LibVer.cmd"
	) else Set "LSN=1"
) >nul 2>nul
(
	Xcopy /y /r /h /g /q /c /e "!SaveFolder!\*" "..\"
	Rd /s /q "!SaveFolder!\"
) >nul 2>nul
Goto :Eof

:Self
(
	Call Download.dll.cmd Server UpdateSelf.rar "%~dp0UpdateSelf.rar"
	%RAR% "%~dp0UpdateSelf.rar" "%~dp0"
	Del /f /q "%~dp0UpdateSelf.rar"
	Start !min! "" "%~f0" %GKW%
	Exit
) >nul 2>nul
Exit

:User
Call "Modules\NormalRun.cmd"
Call "%~dp0Config.dll.cmd" Set.Color
Title Loings Total Security
(
Cls
Echo.  Loings Total Security          更新
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.
Echo.        正在检查更新...
Echo.
)
(
	Del /q ""%~dp0LTSVer.cmd" >nul 2>nul
	Call "%~dp0Download.dll.cmd" Server LTSVer.cmd "%~dp0LTSVer.cmd"
	If exist "%~dp0LTSVer.cmd" (
		Call "%~dp0LTSVer.cmd"
	) else Goto :Err_1
	If exist "%~dp0Modules\LibVer.cmd" Call "%~dp0Modules\LibVer.cmd"	%=本地版本=%
	If exist "%~dp0Modules\ProVer.cmd" Call "%~dp0Modules\ProVer.cmd"	%=本地版本=%
)
If "%Force%"=="0" (						%=判断是否更新=%
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
Echo.  Loings Total Security          更新
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.
Echo.        正在更新...
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
Echo.  Loings Total Security          更新
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.
Echo.        更新已完成。
Echo.
Start /i /low /min "Loings Total Security %Random%" %Windir%\system32\cmd.exe /d /c Call "%~dp0OwnSafe.cmd"
Timeout /t 3 >nul
Exit
)
:U_N
(
Cls
Echo.  Loings Total Security          更新
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.
Echo.        你的程序是最新的。
Echo.
Start /i /low /min "Loings Total Security %Random%" %Windir%\system32\cmd.exe /d /c Call "%~dp0OwnSafe.cmd"
Timeout /t 3 >nul
Exit
)
:Err_1
(
Echo.        未成功获取更新信息。
Start /i /low /min "Loings Total Security %Random%" %Windir%\system32\cmd.exe /d /c Call "%~dp0OwnSafe.cmd"
Exit
)