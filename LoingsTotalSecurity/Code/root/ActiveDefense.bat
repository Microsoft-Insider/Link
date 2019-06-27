@(Echo off					%=关闭回显=%
Set "Admin=True"
Reg query "HKU\S-1-5-19" >nul 2>nul||Set "Admin=False"	%=权限检测=%
If not exist "%~dp0Registry\SafetyCenter\ActiveDefense\True.cmd" Goto :Next
)
::获取批处理路径
For /f "tokens=2,3" %%A in ("%CMDCMDLINE%") do (
	If exist "%%~fB" (
		Set "Run.Path.Program=%%~fB"
		Set "program_name=%%~nxB"
		Set "program_path=%%~dpB"
	) else For /f "tokens=2,*" %%C in ("%CMDCMDLINE%") do (
		If exist "%%~fD" (
			Set "Run.Path.Program=%%~fD"
			Set "program_name=%%~nxD"
			Set "program_path=%%~dpD"
		) else For /f "tokens=2,3" %%E in ("%CMDCMDLINE:"=%") do (
			If exist "%%~fF" (
				Set "Run.Path.Program=%%~fF"
				Set "program_name=%%~nxF"
				Set "program_path=%%~dpF"
			) else Goto :Next
		)
	)
) 2>nul
::直接授权白名单
(
	If "%Run.Path.Program%"=="" (
		Goto :Next
	) else If /i "%program_path%"=="%~dp0" (
		Goto :Next
	) else If /i "%program_path%"=="%~dp0Modules\" (
		Goto :Next
	) else If /i "%program_path%"=="%~dp0Tools\" (
		Goto :Next
	)
	Goto :NR
) 2>nul
Goto :NR

:NR
::响应授权
Find "%Run.Path.Program%" "%~dp0Data\Perm.bat">nul 2>nul&&Goto :Next
Call :Hash.Scan "%Run.Path.Program%"
If "%Admin%"=="True" (
	Goto :LDS
) else Goto :Next
Goto :Next

:Hash.Scan
::采用哈希库扫描程序
Certutil -hashfile "%~1" SHA256 | Findstr /v ": hashfile">"%~dp0Temp\temp.hash"
(
	Set "B=False"
	Set /p Hash.Code=<"%~dp0Temp\temp.hash"
) >nul 2>nul
If "%Hash.Code:~2,1%"==" " Set "Hash.Code=%Hash.Code: =%"
Find "%Hash.Code%" "%~dp0Library\Lib.SHA256_1.vsh" >nul 2>nul&&(
	Set "B=True"
	Call "%~dp0Config.dll.cmd" Set.Color
	Cls
	Echo.  Loings Total Security  -  Active Defense
	Echo.&Echo.&Echo.&Echo.
	Echo.        正在处理威胁
	Echo.        "%~1"
	Echo.&Echo.
	Call :Deleter "%~1"
	Goto :Block
)
Echo."%Run.Path.Program%">"%~dp0Temp\AD.LastRun.tmp"
Goto :Eof

:Block
(
Cls
Echo.  Loings Total Security  -  Active Defense
Echo.&Echo.&Echo.&Echo.
Echo.          已成功拦截威胁，
Echo.          原文件已移动至隔离区。
Echo.&Echo.
Timeout /t 5 >nul
Exit
)
Exit

:Deleter
::删除威胁程序
Set "RA=RecoveryArea\$~@DangerousProcedure.{S-1-5-21-3735454642}"
:D
(
	Takeown /r /d y /f %1 
	Echo.Y|Cacls %1 /t /c /g %Username%:F
	Taskkill /f /im %~nx1
	Xcopy /y /c "%~1" "%~dp0%RA%\"
) >Nul 2>Nul
For /f %%a in ('Cscript //nologo "%~dp0Modules\GUID.vbs"') do (
	Ren "%~dp0%RA%\%~nx1" "%%a.ra" >nul 2>nul
	Echo.%%a.ra %~f1 >>"%~dp0%RA%\FilesImage.fi"
)
:DF1
(
	Del /F /Q %P% "%~1"
	Del /F /S /Q %P% "%~1\*.*"
	Del /F /A /Q %P% "\\?\%~1"
	Del /F /Q /A:S %P% "\\?\%~1"
	Del /F /Q /A:L %P% "\\?\%~1"
	Del /F /Q /A:R %P% "\\?\%~1"
	Del /F /Q /A:H %P% "\\?\%~1"
	Del /F /Q /A:I %P% "\\?\%~1"
	Del /F /Q /A:A %P% "\\?\%~1"
	Del /S /F /Q %P% "%~1\*.*"
	Rd /S /Q %1
	Set "Data=%~1"
) >Nul 2>Nul
(
	Rd /S /Q "%Data:~0,2%\\%Data:~2,500%\\"
	Rd /S /Q "\\?\%~1"
	Rd /S /Q "\\?\%~1\\"
) >Nul 2>Nul
Goto :Eof

:LDS
(
Call "%~dp0Config.dll.cmd" Set.Color
Cls
Echo.  Loings Total Security  -  Active Defense
Echo.
Echo.
Echo.
Echo.
Echo.        请稍等...
Echo.
Echo.
)
::配置变量信息
(
	For %%a in (Name,Info,Version,Safe,MinEnv,Wirter,Writter,SHA256,VerCode,PublicKey,PrivateVer) do (
		Set "LOINGS-SA_%%a="
	)
	For %%a in (RegVersion,RECE,EFA,Hash.Code,Hash.Fail) do (
		Set "%%a="
	)
	Set PN=未知应用程序
	Set LSW=未知的发布者
	Set Hash=未发现文件指纹
	Set "Code=%Run.Path.Program%"
)
::检测程序签名
Findstr "%Var.1%%Var.2%_4" "%Code%" >nul 2>nul || Goto :Loop
Findstr "^Set.LOINGS-SA_" "%Code%"|Findstr /v "&" |Findstr /v "|" |Findstr /v "Set./p" >"%~dp0Temp\SetTemp.cmd"
Call "%~dp0Temp\SetTemp.cmd"
Del /f /q "%~dp0Temp\SetTemp.cmd" >nul 2>nul
(
	If Defined LOINGS-SA_Name Set "LOINGS-SA_Name=%LOINGS-SA_Name:~0,-1%"
	If Defined LOINGS-SA_Writter Set "LOINGS-SA_Writter=%LOINGS-SA_Writter:~0,-1%"
	If Defined LOINGS-SA_VerCode Set "LOINGS-SA_VerCode=%LOINGS-SA_VerCode:~0,-1%"
	If Defined LOINGS-SA_PublicKey Set "LOINGS-SA_PublicKey=%LOINGS-SA_PublicKey:~0,-1%"
	If not Defined LOINGS-SA_PrivateVer Goto :Loop
)
Set "PN=%LOINGS-SA_Name%"
Set "LSW=%LOINGS-SA_Writter%"
If "%LOINGS-SA_Writter%"=="" Set "LSW=%LOINGS-SA_Wirter%"
If "%PN%"=="" Set PN=未知应用程序
If "%LSW%"=="" Set LSW=未知的发布者
If not "%PN%"=="未知应用程序" If "%LOINGS-SA_Wirter%"=="LOINGS_Corporation_O1" Set "LSW=LOINGS Corporation"
If not "%PN%"=="未知应用程序" If "%LOINGS-SA_Writter%"=="LOINGS_Corporation_O1" Set "LSW=LOINGS Corporation"
Findstr /v "^Set.LOINGS-SA_VerCode" "%Code%" >"%~dp0Temp\HashSign.Ver.tmp"
Echo."%LOINGS-SA_PublicKey%">"%~dp0Temp\PublicKey.key"
Copy /b "%~dp0Temp\HashSign.Ver.tmp" + "%~dp0Temp\PublicKey.key" "%~dp0Temp\NewFile.tmp" >nul 2>nul
Certutil -hashfile "%~dp0Temp\NewFile.tmp" SHA256|Findstr /v "哈希 hashfile" >"%~dp0Temp\HashSign.Code.tmp"
For /F "usebackq delims=" %%i in ("%~dp0Temp\HashSign.Code.tmp") do Set "Hash.Code=%%i"
Del /f /q "%~dp0Temp\HashSign.Ver.tmp" "%~dp0Temp\HashSign.Code.tmp" "%~dp0Temp\PublicKey.key" "%~dp0Temp\NewFile.tmp" >nul 2>nul
If "%Hash.Code:~2,1%"==" " Set "Hash.Code=%Hash.Code: =%"
If "%LOINGS-SA_VerCode%"=="%Hash.Code%" (
	Set "Hash=Sign4.0 （签名有效）"
	Set "HashFail="
) else (
	Set "Hash=Sign4.0 （文件被更改）"
	Set "HashFail=True"
)
Goto :Loop

:Loop
(
Call "%~dp0Config.dll.cmd" Set.Color
If "%LSW%"=="未知的发布者" Goto :NoSign
If "%HashFail%"=="True" Goto :NoSign
Cls
Echo.  Loings Total Security  -  Active Defense
Echo.
Echo.
Echo.   你要允许此应用对你的设备进行更改吗？
Echo.
Echo.
)
Echo.     程序名称:"%program_name%"
Echo.       发布者:"%LSW%（%LOINGS-SA_PublicKey:~0,10%...）"
Echo.               %Hash%
Echo.
:Back_C
Set Run.Path.Program >"%~dp0Temp\AD.Pid.%RandomCode%.txt" 2>nul
For /F "usebackq tokens=1* delims==" %%a IN ("%~dp0Temp\AD.Pid.%RandomCode%.txt") do (
	Echo.     程序路径:"%%b"
)
(
Echo.
Echo.       Y.  授权运行     N.  阻止运行（Auto in 30s）
Echo.
Echo.       R.  运行一次     D.  清除该程序
Echo.
Echo.
)
For %%a in (Name,Info,Version,Safe,MinEnv,Wirter,Writter,SHA256,VerCode,PublicKey,PrivateVer) do (
	Set "LOINGS-SA_%%a="
)
For %%a in (PN,LSW,RegVersion,RECE,Hash,EFA,Hash.Code,Hash.Fail) do (
	Set "%%a="
)
Choice /t 30 /d N /c YNRD /n /m 选择：
Set "Choice=%Errorlevel%"
(
Cls
If "%Choice%"=="4" Goto :D
If "%Choice%"=="3" Goto :Next
If "%Choice%"=="2" Goto :N
If "%Choice%"=="1" Goto :Re
Goto :Loop
)
Exit

:NoSign
(
Cls
Echo.  Loings Total Security  -  Active Defense
Echo.
Echo.
Echo.   你想允许来自未知发布者的以下程序对你的设备进行更改吗？
Echo.
Echo.
Echo.     程序名称:"%program_name%"
Echo.       发布者:"未知"
Echo.
Echo.
)
Goto :Back_C

:D
Echo.正在清除程序...
Call :Deleter "%Run.Path.Program%"
Echo.成功完成。
Timeout /t 3 >nul 2>nul
Exit

:Re
Set Run.Path.Program >>"%~dp0Data\Perm.bat"
Goto :Next

:N
Exit

:Next
Color 07
For %%a in (Admin,Errorlevel,Run.Path.Program,B,Code,Hash.Code,Choice,program_name,program_path) do (
	Set "%%a="
)
@Echo on

