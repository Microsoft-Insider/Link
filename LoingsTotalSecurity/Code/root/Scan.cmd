If /i "%~1"=="Auto" Goto :Auto
If /i "%~1"=="User" Goto :User
Exit

:User
(
Cls
Echo.  Loings Total Security          扫描
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.     提供一个文件路径以扫描
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
)
Set Pro.Path=
Call Modules\Select_File.cmd Pro.Path
Set "SP.Path=%Pro.Path%"
If "%SP.Path%"=="" Goto :Eof
If not exist "%SP.Path%" Goto :User
Goto :ScanBy
Goto :Eof

:ScanBy
(
Cls
Echo.  Loings Total Security          扫描
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.        正在扫描批处理
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.          正在扫描："%SP.Path%"
Echo.
)
Set /p=".           开始扫描 " <nul
Set "B=False"
Set "Warnning.Level.Num=0"
Set "Safe=安全。"
Set /p="哈希分析 " <nul
Call ScanHash.dll.cmd "%SP.Path%"					%=扫描引擎=%
If "%B%"=="True" (
	Echo. 哈希引擎检测到威胁
	Set "Safe=构成威胁，已处理。"
	Call "%~dp0Deleter.cmd" "%SP.Path%"				%=强制删除并移动到隔离区=%
	Goto :UE
)
Set /p="脱壳解密 " <nul
Call Shell.dll.cmd "%SP.Path%" >nul 2>nul				%=解密脱壳=%
Call ActiveDefenseIni.cmd >nul 2>nul					%=DEBUG=%
Set /p="权限分析 " <nul
Call Permissions.dll.cmd Ver "%~dp0Temp\decrypt_code.tmp" >nul		%=检测权限要求=%
Cd /d "%~dp0"								%=切换工作目录=%
Set /p="行为分析 " <nul
Call "%~dp0Variable\OutSetVar.tmp.bat"					%=读取行为列表=%
Call "%~dp0BehavioralLib\Tick.1.cmd" "%~dp0Temp\decrypt_code.tmp"	%=分析行为=%
If "!Warnning.Level.Num!"=="" Echo.Not Found Variable. - Warnning.Level.Num = ? &&Pause
If !Warnning.Level.Num! GEQ 8 (
	Set "B=True"
) else (
	Set "B=!B!"
)
If "!B!"=="True" (
	Echo. 特征引擎检测到威胁
	Set "Safe=构成威胁，已处理。"
	Call "%~dp0Deleter.cmd" "!SP.Path!"				%=强制删除并移动到隔离区=%
)
Set /p="扫描完成 " <nul

:UE
(
Cls
Echo.  Loings Total Security          扫描
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.        扫描已完成
Echo.
Echo.
Echo.
Echo.               文件!Safe!
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.按任意键返回
Pause >nul
Goto :Eof
)
Goto :Eof

:Auto
Cls
Echo.  Loings Total Security          扫描
Echo. _______________________________________________________________________________________________________
Echo.
Echo.     选择一个磁盘进行扫描
Echo.
Wmic logicaldisk where drivetype=3 get deviceid 2>nul|Find ":" >Temp\Scan.r.tmp
Wmic logicaldisk where drivetype=2 get deviceid 2>nul|Find ":" >>Temp\Scan.r.tmp
Wmic logicaldisk where drivetype=4 get deviceid 2>nul|Find ":" >>Temp\Scan.r.tmp
For /f %%a in (Temp\Scan.r.tmp) do (
	Echo.          %%a
)
Echo.
Echo.  0. 返回
Choice /C abcdefghijklmnopqrstuvwxyz0 /N /M ">选择："
If Errorlevel 27 Goto :Eof
Echo.Loading...
If Errorlevel 26 (Set "D=Z:"&& Goto Search
) else If Errorlevel 25 	(Set "D=Y:"&& Goto Search
) else If Errorlevel 24 	(Set "D=X:"&& Goto Search
) else If Errorlevel 23 	(Set "D=W:"&& Goto Search
) else If Errorlevel 22 	(Set "D=V:"&& Goto Search
) else If Errorlevel 21 	(Set "D=U:"&& Goto Search
) else If Errorlevel 20 	(Set "D=T:"&& Goto Search
) else If Errorlevel 19 	(Set "D=S:"&& Goto Search
) else If Errorlevel 18 	(Set "D=R:"&& Goto Search
) else If Errorlevel 17 	(Set "D=Q:"&& Goto Search
) else If Errorlevel 16 	(Set "D=P:"&& Goto Search
) else If Errorlevel 15 	(Set "D=O:"&& Goto Search
) else If Errorlevel 14 	(Set "D=N:"&& Goto Search
) else If Errorlevel 13 	(Set "D=M:"&& Goto Search
) else If Errorlevel 12 	(Set "D=L:"&& Goto Search
) else If Errorlevel 11 	(Set "D=K:"&& Goto Search
) else If Errorlevel 10 	(Set "D=J:"&& Goto Search
) else If Errorlevel 9 		(Set "D=I:"&& Goto Search
) else If Errorlevel 8 		(Set "D=H:"&& Goto Search
) else If Errorlevel 7 		(Set "D=G:"&& Goto Search
) else If Errorlevel 6 		(Set "D=F:"&& Goto Search
) else If Errorlevel 5 		(Set "D=E:"&& Goto Search
) else If Errorlevel 4 		(Set "D=D:"&& Goto Search
) else If Errorlevel 3 		(Set "D=C:"&& Goto Search
) else If Errorlevel 2 		(Set "D=B:"&& Goto Search
) else If Errorlevel 1 		(Set "D=A:"&& Goto Search
) else If Errorlevel 0 		Echo.Error - 无效的ERRORLEVEL值。
)
Goto :Auto
:Search
If not exist "%D%" Goto :Auto
(
Cls
Echo.  Loings Total Security          扫描
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.               H.        快速扫描（Auto in 5s）
Echo.                           采用哈希值进行匹配扫描。
Echo.
Echo.               P.        完全扫描
Echo.                           采用行为特征分析进行扫描。
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.  B. 返回
)
Choice /m ">选择：" /n /c HPB /t 5 /d H
Set "SetData=%Errorlevel%"
(
If "%SetData%"=="1" Set "Scan.type=Hash"
If "%SetData%"=="2" Set "Scan.type=Beha"
If "%SetData%"=="3" Goto :Auto
)

(
Cls
Echo.  Loings Total Security          扫描
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.        正在准备扫描
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
)
::删除缓存
Del /f /q Temp\*.lts >nul 2>nul
::获取全盘的批处理路径
If exist "%D%\" (
	Dir /a /b /s "%D%\*.bat" "%D%\*.cmd" >>Temp\Scan.Path.lts 2>nul
)
::Debug
Find /v "%~dp0" <"Temp\Scan.Path.lts"|Find /v "目录名称"|Findstr /v "& | ) ( > <"|Findstr ":" >Temp\Scan.Path.R.lts
SetLocal EnableDelayedExpansion
Set "Num=0"&Set "Num2=0"&Set "Num3=0"&Set "Tot=0"
::获取文件总数
For /f %%a in (Temp\Scan.Path.R.lts) do (
	Set /a "Tot+=1"
)
If "%Scan.type%"=="Hash" Goto :HashScan
::扫描文件
Goto Scan.%Scan.type%
:Scan.Hash
For /f "tokens=1*" %%a in (Temp\Scan.Path.R.lts) do (
	Set "PPath=%%a"
	If not "%%b"=="" Set "PPath=%%a %%b"
	Call :Show "!PPath!" !Num! %=UI=%
	Call ScanHash.dll.cmd "!PPath!"		%=扫描引擎=%
	If "!B!"=="True" (
		Set "Point!Num2!=!PPath!"	%=如果检测到威胁，将其路径保存并增加威胁数=%
		Set /a "Num2+=1"
	)
	Set /a Num+=1
)
Goto :InWarn

:Scan.Beha
For /f "tokens=1*" %%a in (Temp\Scan.Path.R.lts) do (
	Set "PPath=%%a"
	If not "%%b"=="" Set "PPath=%%a %%b"
	Call :Show "!PPath!" !Num! %=UI=%
	Call Permissions.dll.cmd Ver "!PPath!"			%=扫描引擎=%
	Cd /d "%~dp0"						%=切换工作目录=%
	Call "%~dp0Variable\OutSetVar.tmp.bat"			%=读取行为列表=%
	Call "%~dp0BehavioralLib\Tick.1.cmd" "!PPath!"		%=分析行为=%
	If !Warnning.Level.Num! GEQ 8 (
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
For /l %%a in (0,1,!Num2!) do (
	If not defined Point%%a Goto :End
	Call :Op "!Point%%a!" %%a %=UI=%
	Call "Deleter.cmd" "!Point%%a!"	%=强制删除并移动到隔离区=%
)
::结束
Goto :End

:HashScan
Call "%~dp0Scan_B.cmd"
Goto :Eof

:Show
(
Cls
Echo.  Loings Total Security          扫描
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.        正在扫描批处理
Echo.
Echo.               已扫描 "%~2" 个文件
Echo.               已发现 "!Num2!" 个威胁
Echo.               共 "!Tot!" 个文件
Echo.
Echo.
Echo.          正在扫描："%~1"
Goto :Eof
)

:Op
(
Cls
Echo.  Loings Total Security          扫描
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.        正在自动处理威胁
Echo.
Echo.
Echo.               已发现 "!Num2!" 个威胁
Echo.               正在处理第 "%~2" 个
Echo.
Echo.
Echo.          正在处理："%~1"
Goto :Eof
)

:End
(
Cls
Echo.  Loings Total Security          扫描
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.        扫描已完成
Echo.
Echo.
Echo.               已发现并处理 "!Num2!" 个威胁。
Echo.               
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.按任意键返回
Pause >nul
Goto :Eof
)
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS 全功能安全套装'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=07c3b7d5ffa1cfa3a18c86c281bb710797a9c8ffd06270814acb6e2897158b8f'
Set LOINGS-SA_VerCode=0f81b0c34af26fdec49d000ba3b2bf0c344b05dd5d1cdb869b22a5f4559c0bf1'
