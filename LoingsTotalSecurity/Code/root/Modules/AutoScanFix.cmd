@Echo off
:SCM
Set ScanNow=ɨ��CMD�ٳ�
Set N=1
Set V=0

:Scan
(
Cls
Echo. Loings Total Security
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.  ����ɨ��
Echo.
Echo.
Echo.
Echo.          ���ڣ�%ScanNow%
Echo.
Echo.
Echo.          �޸���%V%
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
Goto SC%N%

::Num2
:SC1
Set reg=
For /f "tokens=1,2,*" %%i in ('Reg query "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v Autorun ^|find /i "Autorun"') do set "reg=%%k"
If not "%reg%"=="" If not "%reg%"=="L:\System\Defender\ActiveDefense.cmd" Reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v Autorun /f /d "" >nul 2>nul&&Set /A V=%V%+1&&Set RGAR=1
For /f "tokens=1,2,*" %%i in ('Reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor" /v Autorun ^|find /i "Autorun"') do set "reg=%%k"
If not "%reg%"=="" If not "%reg%"=="L:\System\Defender\ActiveDefense.cmd" Reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor" /v Autorun /f /d "" >nul 2>nul&&Set /A V=%V%+1&&Set RGAR=1
If "%RGAR%"=="1" Call ActiveDefenseIni.cmd
Set ScanNow=ɨ���Զ�����
Set /A N=%N%+1
Goto Scan

::Num2
:SC2
If exist %SystemDrive%\Autorun.inf Del /f /q %SystemDrive%\Autorun.inf >nul 2>nul&&Set /A V=%V%+1
If exist L:\Autorun.inf Del /f /q L:\Autorun.inf>nul 2>nul&&Set /A V=%V%+1
Set ScanNow=ɨ���ļ���
Set /A N=%N%+1
Goto Scan

::Num18
:SC3
For %%a in (Shutdown.exe,Copy.exe,Xcopy.exe,Ping.exe,Help.exe,Choice.exe,Timeout.exe,cmd.exe,Reg.*,Regini.*,Msg.*,reboot.exe,$~*.*) do (
	If exist "%~dp0%%a" (
		Del /s /f /q "%~dp0%%a" >nul 2>nul
		Set /A "V=!V!+1"
	)
)
Dir /a:d /b "%SystemDrive%\ProgramFiles" >Temp\Defender.tmp.cmd
For /f "usebackq delims=" %%a in (Temp\Defender.tmp.cmd) do (
	If exist "%SystemDrive%\ProgramFiles\%%a" (
		Rd /q "%SystemDrive%\ProgramFiles\%%a" >nul 2>nul&&(
			Set /A "V=!V!+1"
		)
	)
)
Del /f /q Temp\Defender.tmp.cmd >nul 2>nul
Rd %SystemDrive%\ProgramFiles\�½��ļ���\ /s /q >nul 2>nul&&Set /A V=%V%+1
Rd %SystemDrive%\ProgramFiles\�½����İ�\ /s /q >nul 2>nul&&Set /A V=%V%+1
Rd %SystemDrive%\ProgramFiles\�½��ı��ĵ�.txt\ /s /q >nul 2>nul&&Set /A V=%V%+1
If exist %SystemDrive%\ProgramFiles\�½�*.* Del %SystemDrive%\ProgramFiles\�½�*.* /s /f /q >nul 2>nul&&Set /A V=%V%+1
Set ScanNow=������������
Set /A N=%N%+1
Goto Scan

::Num4
:SC4
Taskkill /F /IM "PING.EXE" >NUL 2>NUL&&Set /A V=%V%+1
Taskkill /F /IM "attrib.exe" >NUL 2>NUL&&Set /A V=%V%+1
Taskkill /F /IM "find.exe" >NUL 2>NUL&&Set /A V=%V%+1
Taskkill /F /IM "findstr.exe" >NUL 2>NUL&&Set /A V=%V%+1
Set ScanNow=ɾ�����繲��
Set /A N=%N%+1
Goto Scan

::Num26
:SC5
For %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
	Net share %%i$ /d >nul 2>nul&&Set /A V=!V!+1
)
Net share admin$ /d >nul 2>nul
Net share ipc$ /d >nul 2>nul
Set ScanNow=ɨ��%Windir%
Set /A N=%N%+1
Goto Scan

::Num19
:SC6
For /l %%i in (0,1,9) do (
	If exist "%windir%\System32\%%i" (
		Del %windir%\%%isy.exe >nul 2>nul
		Set /A V=!V!+1
	)
)
For %%i in (logo1_.exe,vdll.dll,tdll.dll,kill.exe,sws32.dll,rundl132.exe,bootconf.exe,dll.dll) do (
	If exist "%windir%\System32\%%i" (
		Del /f /q "%windir%\System32\%%i"	>nul 2>nul
		Set /A V=!V!+1
	)
)
If exist "%windir%\system32\ShellExt\svchs0t.exe" (
	Del "%windir%\system32\ShellExt\svchs0t.exe" >NUL
	Set /A V=!V!+1
)
Set ScanNow=ɨ��Internet Explorer
Set /A N=%N%+1
Goto Scan

::Num10
:SC7
For /l %%i in (0,1,9) do (
	If exist "%systemdrive%\Program Files\Internet Explorer\%%isy.exe" (
		Del /f /q "%systemdrive%\Program Files\Internet Explorer\%%isy.exe" >nul 2>nul
		Set /A V=!V!+1
	)
)
Set ScanNow=ɨ��_desktop.ini
Set /A N=%N%+1
Goto Scan

::Num26
:SC8
For %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
	Del %%i:\_desktop.ini >nul 2>nul
)
Set N=F
Goto Scan

:SCF
Cls
Echo. Loings Total Security
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.  ɨ�������
Echo.
Echo.
Echo.
Echo.      ɨ����Ŀ������107
Echo.
Echo.
Echo.      �ѷ��ֲ��޸���%V%
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
Pause >nul
