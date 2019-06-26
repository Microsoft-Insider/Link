@Echo off
If not "%~1"=="" If not "%~2"=="" Goto :Ver
Goto :Eof

:Ver
Set StartCode=
Set CanRun=
If not exist "%~2" Exit
If not exist "%SystemDrive%\$~LTS_Data\" (
	Md "%SystemDrive%\$~LTS_Data\" >Nul 2>Nul
	Echo.Y|Cacls "%SystemDrive%\$~LTS_Data\" /t /c /g %Username%:F >Nul 2>Nul
)
Find "%~2" "%Loings.FileName.Data%\Perm.cmd">nul 2>nul&&Goto :R
Set "FN=%~nx2"
If "%FN:~0,3%"=="BD-" Goto :Block
If /i "%~0"=="%~2" Goto :Self

::	获取其所有变量值
Set Paths=%2
Cd "%~dp2"
Pushd "%~dp2"
Findstr "^Set.=." %2|Findstr /v "& | > < ) ("|Findstr /v "Set./p">%SystemDrive%\$~LTS_Data\SetTemp.cmd 2>nul
Call "%SystemDrive%\$~LTS_Data\SetTemp.cmd"
Del /f /q "%SystemDrive%\$~LTS_Data\SetTemp.cmd" >nul 2>nul

::	重置值
Set "Info1=使用临时文件,获取Windows系统信息,设置Windows用户,Windows开机启动,更改Windows服务,设置Windows自动运行,访问Windows系统文件夹,更改服务,启动服务"
Set "Info2=运行Shutdown.exe,运行Fsutil.exe,设置计划任务,调用程序,结束进程,列出进程,更改文件或文件夹,删除文件或文件夹,复制文件或文件夹,访问ProgramFiles文件夹,"
Set "Info3=重命名文件,获取文件所有权,更改文件属性,更改文件关联,更改文件共享,创建虚拟驱动器,更改文件权限,查看注册表项目信息,更改注册表项目信息,更改服务状态,"
Set "Info4=复制注册表项目信息,更改注册表权限,更改卷装入点,获取地址解析协议,更改地址解析协议,获取或更改启动引导,访问剪切板,调用其他语言脚本,查询服务的状态"
For %%a in (%Info1%%Info2%%Info3%%Info4%) do (
	Set "%%a="
)
Call "%~dp0ResetVar.dll.cmd" ScanBehaRe

::	检测程序行为
Call :Check Ver %2
Goto Set

:Check
(
::Basic
Findstr /i "Del Rmdir Erase Rd" %2 &&Set 删除文件或文件夹=1
Find ">" %2 | Find /i /v ">Nul" &&Set 更改文件或文件夹=1
Findstr /i "Md Mkdir Move MkLink Replace" %2 &&Set 更改文件或文件夹=1
Findstr /i "Ren Rename" %2 &&Set 重命名文件=1
Find /i "Clip " %2 &&Set 访问剪切板=1
Findstr /i "Copy Move" %2 &&Set 复制文件或文件夹=1
::Normal
Find /i "At" %2 && (
	Findstr /i "^At " %2 | Find /i /v "Bat" &&Set 设置计划任务=1
	Find /i "Attrib " %2 &&Set 更改文件属性=1
)
Findstr /i "Assoc Ftype" %2 &&Set 更改文件关联=1
Find /i "Autorun.inf" %2 &&Set 设置Windows自动运行=1
Findstr /i "Bcdedit Bcdboot Bootcfg" %2 &&Set 获取或更改启动引导=1
Find /i "Ca" %2 && (
	Find /i "Call " %2 | Find /v ":" %2 &&Set 调用程序=1
	Find /i "Cacls" %2 &&Set 更改文件权限=1
)
Find /i "Format " %2 &&Set 格式化磁盘=1
Find /i "Fsutil " %2 &&Set 运行Fsutil.exe=1
Find /i "Mountvol" %2 &&Set 更改卷装入点=1
Findstr /i "Powershell Script Vbs Mshta" %2 &&Set 调用其他语言脚本=1
Find /i "Sc " %2 &&(
	Findstr /i "Sc.query" %2 &&Set 查询服务的状态=1
	Findstr /i "Sc.st" %2 &&(
		Findstr /i "Sc.start" %2 &&Set 启动服务=1
		Findstr /i "Sc.stop" %2 &&Set 更改服务状态=1
	)
	Findstr /i "Sc.con" %2 &&(
		Findstr /i "Sc.config" %2 &&Set 更改服务=1
		Findstr /i "Sc.control" %2 &&Set 更改服务状态=1
	)
	Findstr /i "Sc.create" %2 &&Set 更改服务=1
	Findstr /i "Sc.lock" %2 &&Set 更改服务=1
	Findstr /i "Sc.pause" %2 &&Set 更改服务=1
	Find /i "Schtasks" %2 &&Set 设置计划任务=1
)
Find /i "Shutdown " %2 &&Set 运行Shutdown.exe=1
Find /i "St" %2 && (
	Find /i "Start " %2 &&Set 调用程序=1
	Find /i "Subst " %2 &&Set 创建虚拟驱动器=1
)
Findstr /i "Systeminfo" %2 &&Set 获取Windows系统信息=1
Find /i "Ta" %2 && (
	Find /i "Takeown " %2 &&Set 获取文件所有权=1
	Find /i "Tasklist " %2 &&Set 列出进程=1
	Find /i "Taskkill " %2 &&Set 结束进程=1
)
Find /i "Tskill" %2 &&Set 结束进程=1
::More
Find "%%" %2 && (
	Findstr /i "%%Temp%% %%Tmp%%" %2 &&Set 使用临时文件=1
	Findstr /i "%%Systemroot%% %%Windir%%" %2 &&Set 访问Windows系统文件夹=1
	Findstr /i "%%ProgramFiles" %2 &&Set 访问ProgramFiles文件夹=1
)
Find /i "Arp" %2 && (
	Find /i "Arp -a" %2 &&Set 更改地址解析协议=1
	Find /i "Arp -d" %2 &&Set 更改地址解析协议=1
	Find /i "Arp -s" %2 &&Set 获取地址解析协议=1
)
Find /i "Net" %2 && (
	Find /i "Net Pause " %2 &&Set 更改Windows服务=1
	Find /i "Net Share $" %2 &&Set 更改文件共享=1
	Find /i "Net Stop " %2 &&Set 更改Windows服务=1
	Find /i "Net Start " %2 &&Set 更改Windows服务=1
	Find /i "Net User " %2 &&Set 设置Windows用户=1
)
Find /i "Reg" %2 && (
	Findstr /i "Reg.query " %2 &&Set 查看注册表项目信息=1
	Findstr /i "Reg.add" %2 &&Set 更改注册表项目信息=1
	Findstr /i "Reg.delete" %2 &&Set 删除注册表项目信息=1
	Findstr /i "Reg.copy" %2 &&Set 复制注册表项目信息=1
	Findstr /i "RegEdit " %2 &&Set 更改注册表项目信息=1
	Findstr /i "Regini" %2 &&Set 更改注册表权限=1
)
Find /i "Windows" %2 && (
	Find /i "Microsoft\Windows\Start Menu\Programs\Startup" %2 &&Set Windows开机启动=1
	Find /i "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" %2 &&Set Windows开机启动=1
	Find /i "%HOMEDRIVE%\Windows\" %2 &&Set 访问Windows系统文件夹=1
)
) >nul 2>nul
Goto Eof

:Set
Goto SetIn

:Block
Goto SetIn

:Self
Goto SetIn

:SetIn_Out
Del /f /q "%Loings.FileName.Variable%\OutSetVar.%~1.tmp.bat" >nul 2>nul
Echo.^(>>"%Loings.FileName.Variable%\OutSetVar.%~1.tmp.bat"
For /f "usebackq tokens=1,2* delims==" %%a in (
	`Set^|Findstr /v /i "ALL APP COM HOME LO OS Path PROCESSOR USER System"`
) do (
	Echo.Set "%%a=%%b">>"%Loings.FileName.Variable%\OutSetVar.%~1.tmp.bat"
)
Echo.^)>>"%Loings.FileName.Variable%\OutSetVar.%~1.tmp.bat"
Goto :Eof

:SetIn
If /i not "%~1"=="Ver" Goto :SetIn_Out
Del /f /q "%Loings.FileName.Variable%\OutSetVar.tmp.bat" >nul 2>nul
Echo.^(>>"%Loings.FileName.Variable%\OutSetVar.tmp.bat"
For /f "usebackq tokens=1,2* delims==" %%a in (
	`Set^|Findstr /v /i "ALL APP COM HOME LO OS Path PROCESSOR USER System"`
) do (
	Echo.Set "%%a=%%b">>"%Loings.FileName.Variable%\OutSetVar.tmp.bat"
)
Echo.^)>>"%Loings.FileName.Variable%\OutSetVar.tmp.bat"

:Eof
Cd "%~dp2"
Pushd "%~dp2"