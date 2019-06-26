@Echo off
Set Warnning.Level.Num=0
::Total 80
::Basic 3
If "%运行Shutdown.exe%"=="1" (
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+1"
)
If "%结束进程%"=="1" (
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+1"
)
If "%设置Windows用户%"=="1" (
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+1"
)
::Normal 76
If "%格式化磁盘%"=="1" If "%删除文件或文件夹%"=="1" (
	Set "Warnning.By1201=Trojan.Format.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+1"
)
If "%结束进程%"=="1" If "%列出进程%"=="1" (
	Set "Warnning.By1301=Trojan.Progress.Kill.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+2"
)
::2*5=10
If "结束进程"=="1" Findstr /i "Taskkill Tskill" %1 | Findstr /i "explorer taskmgr cmd svchost winlogon" >nul 2>nul&&(
	Set "Warnning.By1302=Trojan.Tkill.Sys.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+2"
)
If "%运行Fsutil.exe%"=="1" (
	Set "Warnning.By1401=Trojan.ProRun.Fusutil.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+2"
)
If "%调用程序%"=="1" Find /i "Start" %1 | Find /i "%%0" >nul 2>nul&&(
	Set "Warnning.By1402=Trojan.Start.RunSelf.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+2"
)
If "%调用程序%"=="1" Find /i "Start" %1 | Find /i "%FN%" >nul 2>nul&&(
	Set "Warnning.By1403=Trojan.Start.RunSelf.2"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+3"
)
If "%获取文件所有权%"=="1" If "%更改文件权限%"=="1" If "%删除文件或文件夹%"=="1" (
	Set "Warnning.By1501=Trojan.Admin.DelFile.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+4"
)
If "%删除文件或文件夹%"=="1" Find "*" %1 >nul 2>nul&&(
	Set "Warnning.By1502=Trojan.DelAll.Warn.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+1"
)
::2*6=12
	If "%删除文件或文件夹%"=="1" If Defined Warnning.By1502 Find "*" %1 | Findstr /i "DEL ERASE" | Findstr /i "%%SystemDrive%% %%SystemRoot%% %%UserProFile%% %SystemDrive% %SystemRoot% %UserProFile%" >nul 2>nul&&(
		Set "Warnning.By1503=Trojan.DelAll.Sys.1"
		Set /a "Warnning.Level.Num=%Warnning.Level.Num%+3"
	)
If "%获取文件所有权%"=="1" If "%更改文件权限%"=="1" If "%删除文件或文件夹%"=="1" If "%更改文件属性%"=="1" (
	Set "Warnning.By1504=Trojan.Admin.DelFile.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+4"
)
If "%结束进程%"=="1" If "%设置Windows用户%"=="1" (
	Set "Warnning.By1601=Trojan.Net.User.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+2"
)
If "%设置Windows用户%"=="1" If "%运行Shutdown.exe%"=="1" (
	Set "Warnning.By1602=Trojan.Net.User.2"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+2"
)
If "%设置Windows用户%"=="1" Findstr /i "NET USER" %1 | Find /i "/add" >nul 2>nul&&(
	Set "Warnning.By1602=Trojan.Net.User.3"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+4"
)
If "%更改文件关联%"=="1" If "%更改文件或文件夹%"=="1" If "%重命名文件%"=="1" Find /i "*." %1 | Findstr /i "Ren" >nul 2>nul&&(
	Set "Warnning.By1701=Trojan.Rename.Assoc.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+3"
)
::1*18=18
	If "%更改文件关联%"=="1" If Defined Warnning.By1701 Find /i "*" %1 | Findstr /i "Ren" | Findstr /i "txt ppt doc xls exe com bat cmd vbs js zip rar 7z cab wim iso lnk reg" >nul 2>nul&&(
		Set "Warnning.By1702=Trojan.BatchRename.Assoc.1"
		Set /a "Warnning.Level.Num=%Warnning.Level.Num%+3"
	)
If "%复制文件或文件夹%"=="1" If "%更改文件或文件夹%"=="1" ( If "%Windows开机启动%"=="1" (
	Set "Warnning.By1801=Trojan.CopyEdit.Warn.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+5"
	) else If "%设置计划任务%"=="1" (
	Set "Warnning.By1802=Trojan.CopyEdit.Warn.2"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+6"
	)
)
If "%复制文件或文件夹%"=="1" Find /i "Copy %%0" %1 >nul 2>nul&&(
	Set "Warnning.By2101=Virus.Copy.CopySelf.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+3"
)
If "%复制文件或文件夹%"=="1" Find /i "Copy %FN%" %1 >nul 2>nul&&(
	Set "Warnning.By2102=Virus.Copy.CopySelf.2"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+3"
)
If "%更改地址解析协议%"=="1" (
	Set "Warnning.By3101=TrojanProxy.Arp.Block.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+2"
)
If "%调用程序%"=="1" Find /i "Start %%1" %1 >nul 2>nul&&(
	Set "Warnning.By4101=Constructor.Start.RunA.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+2"
)
If "%调用程序%"=="1" Find /i "Start %%*" %1 >nul 2>nul&&(
	Set "Warnning.By4102=Constructor.Start.RunA.2"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+2"
)
If "%结束进程%"=="1" If "%调用程序%"=="1" If "%列出进程%"=="1" (
	Set "Warnning.By4203=Constructor.Progress.Run;Kill.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+2"
)
::4204+4205;6+7=13
If "%更改文件或文件夹%"=="1" Find /i "Echo" %1 | Findstr /i "Call Start Goto Del Rd Setx" >nul 2>nul&&(
	Set "Warnning.By4204=Constructor.TrojanMaker.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+2"
)
If "%更改文件或文件夹%"=="1" Find /i "Echo" %1 | Findstr /i "Erase Rmdir Shutdown Mountvol Net.User Attrib Cacls" >nul 2>nul&&(
	Set "Warnning.By4205=Constructor.TrojanMaker.2"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+3"
)
If "%设置计划任务%"=="1" If "%Windows开机启动%"=="1" If "%运行Shutdown.exe%"=="1" (
	Set "Warnning.By5101=Exploit.RestartShutdown.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+5"
)
If "%更改卷装入点%"=="1" Find /i "Mountvol" %1 | Find /i "/d" >nul 2>nul&&(
	Set "Warnning.By6101=Exploit.Mountvol.Del.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+6"
)
If "%获取或更改启动引导%"=="1" (
	Set "Warnning.By7101=Bootkit.Boot.Edit.1"
	Set /a "Warnning.Level.Num=%Warnning.Level.Num%+6"
)