Echo off
Cls
 Color 07
 Title cmd.exe
Cls
 Echo.
 Echo.正在创建虚拟环境变量...
Set "DPF=%~dp0"
Set ALLUSERSPROFILE=Test_Files
Set APPDATA=Test_Files
Set COMPUTERNAME=PC
Set Devmgr_show_Nonrresent_Devices=1
Set FP_NO_HOST_CHECK=NO
Set HOMEDRIVE=Test_Files
Set HOMEPATH=Test_Files
Set LOCALAPPDATA=Test_Files
Set LOGONSERVER=\\PC
Set OS=Windows_NT
Set Path=Test_Files;Test_Files\windows\system32;Test_Files\windows;windows\System32\Wbem;Test_Files\windows\System32\WindowsPowerShell\v1.0\
Set PATHEXT=.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC
Set PROCESSOR_ARCHITECTURE=x64
Set PROCESSOR_IDENTIFIER=Intel core i9 3.4Ghz
Set PROCESSOR_LEVEL=16
Set PROCESSOR_REVISION=0
Set ProgramData=Test_Files
Set ProgramFiles=Test_Files
Set PROMPT=$P$G
Set PSModulePath=
Set PUBLIC=Test_Files
Set SESSIONNAME=Console
CD %SystemDrive%\Windows\System32
Pushd %SystemDrive%\Windows\System32
Set SystemDrive=Test_Files
Set SystemRoot=Test_Files
Set TEMP=Test_Files
Set TMP=Test_Files
Set USERDOMAIN=PC
Set Time=00:00:00.00
Set Date=0000/00/00 周一
Set USERNAME=TestUser
Set USERPROFILE=Test_Files
Set windir=Test_Files
Set windows_tracing_flags=3
Set windows_tracing_logfile=Test_Files\csilogfile.log
Set LOINGS-TEST-SDK=SDK
Cls
 Echo.
 Echo.正在创建虚拟运行文件夹...
Md %CD%\Test_Files
Color F3
Setlocal Enabledelayedexpansion
Cls
:START
Echo.Command Test Version
Echo.Microsoft Windows
Echo.Copyright (c) Microsoft Corporation.  All rights reserved.
:RS
Echo.
Set Error_5932=
Set CMD_SET=
Set /p CMD_SET=Test Command^>
If "%CMD_SET%"=="" Goto RS
echo. Safe Checking...
Color F3
If not "%CMD_SET:~100,1%"=="" Goto Error-00
If /i "%CMD_SET:~0,1%"=="/" Goto RS
If /i "%CMD_SET:~1,1%"=="/" Goto RS
If /i "%CMD_SET:~2,1%"=="/" Goto RS
Call "%DPF%#TSC_Core.cmd" %CMD_SET%
Set Run=OkeyToRun_Code854791
If "%Error_5932%"=="NoRun" Goto Question
If "%Error_5932%"=="Stop" Goto RS
:Run
If not "%Run%"=="OkeyToRun_Code854791" Goto RS
echo. Running...
Call "%DPF%#TSC_Start.cmd" %CMD_SET%
echo. Finished.
Goto RS
Goto RS
Goto RS
Goto RS
Goto RS

:Error-00
Echo.指令过长；
Echo.超过50个字符的部分将不受检查。
Set Error_5932=NoRun
Goto RS

:Question
Set Error_5932=
Choice /C YN /M "是否继续运行？"
If /i "%ERRORLEVEL%"=="1" Goto Run
If /i "%ERRORLEVEL%"=="2" Goto BR
Goto BR

:BR
Echo.已阻止操作。
Goto RS