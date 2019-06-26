@Echo off&Cls
Set "Number=%~1"
Set "RandomCode=%Random%"
Cd /d "%~dp0"
SetLocal EnableDelayedExpansion
Del Temp\%Number%.run.bat >nul 2>nul
::扫描文件
Goto Scan.%Scan.type%
:Scan.Hash
For /f "tokens=1*" %%a in (Temp\%Number%.lts) do (
	Set "PPath=%%a"
	If not "%%b"=="" Set "PPath=%%a %%b"
	Call :Show "!PPath!" !Num!
	Call :ScanHash "!PPath!"		%=扫描引擎=%
	If "!B!"=="True" (
		Set "Point!Num2!=!PPath!"	%=如果检测到威胁，将其路径保存并增加威胁数=%
		Set /a "Num2+=1"
	)
	Set /a Num+=1
)
Goto :InWarn

:ScanHash
Certutil -hashfile "%~1" SHA256 | Findstr /v ": hashfile">Temp\%RandomCode%.temp.hash
(
Set "B=False"
Set /p Hash.Code=<Temp\%RandomCode%.temp.hash
) >nul 2>nul
If "%Hash.Code:~2,1%"==" " Call :GetCode
Find "%Hash.Code%" "Library\%Number%Lib.SHA256_1.vsh" >nul 2>nul&&(
	Set "B=True"
)
Goto :Eof
:GetCode
Set "Hash.Code=%Hash.Code:~0,2%%Hash.Code:~3,2%%Hash.Code:~6,2%%Hash.Code:~9,2%%Hash.Code:~12,2%%Hash.Code:~15,2%%Hash.Code:~18,2%%Hash.Code:~21,2%%Hash.Code:~24,2%%Hash.Code:~27,2%%Hash.Code:~30,2%%Hash.Code:~33,2%%Hash.Code:~36,2%%Hash.Code:~39,2%%Hash.Code:~42,2%%Hash.Code:~45,2%%Hash.Code:~48,2%%Hash.Code:~51,2%%Hash.Code:~54,2%%Hash.Code:~57,2%%Hash.Code:~60,2%%Hash.Code:~63,2%%Hash.Code:~66,2%%Hash.Code:~69,2%%Hash.Code:~72,2%%Hash.Code:~75,2%%Hash.Code:~78,2%%Hash.Code:~81,2%%Hash.Code:~84,2%%Hash.Code:~87,2%%Hash.Code:~90,2%%Hash.Code:~93,2%"
Goto :Eof

:Scan.Beha
For /f "tokens=1*" %%a in (Temp\%Number%.lts) do (
	Set "PPath=%%a"
	If not "%%b"=="" Set "PPath=%%a %%b"
	Call :Show "!PPath!" !Num!
	Call %Number%Permissions.dll.cmd Ver "!PPath!"			%=扫描引擎=%
	Cd /d "%~dp0"						%=切换工作目录=%
	Call "%~dp0Variable\OutSetVar.tmp.bat"			%=读取行为列表=%
	Call "%~dp0BehavioralLib\Tick.1.cmd" "!PPath!"		%=分析行为=%
	If !Warnning.Level.Num! GEQ 7 (
		Set "B=True"
	) else (
		Set "B=False"
	)
	If "!B!"=="True" (
		Set "Point!Num2!=%%a"	%=如果检测到威胁，将其路径保存并增加威胁数=%
		Set /a "Num2+=1"
	)
	Set /a Num+=1
)
Goto :InWarn

::威胁处理
:InWarn
For /f %%a in (Temp\%Number%.lts) do (
	Set /a "Tots+=1"
)
For /l %%a in (0,1,!Num2!) do (
	If not defined Point%%a Goto :End
	Call :Op %%a
	Call "Deleter.cmd" "!Point%%a!"	%=强制删除并移动到隔离区=%
)
::结束
Goto :End

:Show
Echo.Set "Scaned%Number%=!Num!">"Temp\%Number%.run.bat"
(
Echo.Set "WarnP%Number%=!Num2!"
Echo.Set "Done=!PPath!"
Echo.Set "Killed%Number%=0"
Echo.Set "ODone="
) >>"Temp\%Number%.run.bat"
Goto :Eof

:Op
Echo.Set "Doing%Number%=%Tots%">"Temp\%Number%.run.bat"
(
Echo.Set "Killed%Number%=%~1"
Echo.Set "ODone=!Point%%a!"
Echo.Set "WarnP%Number%=!Num2!"
) >>"Temp\%Number%.run.bat"
Goto :Eof

:End
Exit