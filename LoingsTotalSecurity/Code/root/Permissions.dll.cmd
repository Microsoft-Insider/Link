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

::	��ȡ�����б���ֵ
Set Paths=%2
Cd "%~dp2"
Pushd "%~dp2"
Findstr "^Set.=." %2|Findstr /v "& | > < ) ("|Findstr /v "Set./p">%SystemDrive%\$~LTS_Data\SetTemp.cmd 2>nul
Call "%SystemDrive%\$~LTS_Data\SetTemp.cmd"
Del /f /q "%SystemDrive%\$~LTS_Data\SetTemp.cmd" >nul 2>nul

::	����ֵ
Set "Info1=ʹ����ʱ�ļ�,��ȡWindowsϵͳ��Ϣ,����Windows�û�,Windows��������,����Windows����,����Windows�Զ�����,����Windowsϵͳ�ļ���,���ķ���,��������"
Set "Info2=����Shutdown.exe,����Fsutil.exe,���üƻ�����,���ó���,��������,�г�����,�����ļ����ļ���,ɾ���ļ����ļ���,�����ļ����ļ���,����ProgramFiles�ļ���,"
Set "Info3=�������ļ�,��ȡ�ļ�����Ȩ,�����ļ�����,�����ļ�����,�����ļ�����,��������������,�����ļ�Ȩ��,�鿴ע�����Ŀ��Ϣ,����ע�����Ŀ��Ϣ,���ķ���״̬,"
Set "Info4=����ע�����Ŀ��Ϣ,����ע���Ȩ��,���ľ�װ���,��ȡ��ַ����Э��,���ĵ�ַ����Э��,��ȡ�������������,���ʼ��а�,�����������Խű�,��ѯ�����״̬"
For %%a in (%Info1%%Info2%%Info3%%Info4%) do (
	Set "%%a="
)
Call "%~dp0ResetVar.dll.cmd" ScanBehaRe

::	��������Ϊ
Call :Check Ver %2
Goto Set

:Check
(
::Basic
Findstr /i "Del Rmdir Erase Rd" %2 &&Set ɾ���ļ����ļ���=1
Find ">" %2 | Find /i /v ">Nul" &&Set �����ļ����ļ���=1
Findstr /i "Md Mkdir Move MkLink Replace" %2 &&Set �����ļ����ļ���=1
Findstr /i "Ren Rename" %2 &&Set �������ļ�=1
Find /i "Clip " %2 &&Set ���ʼ��а�=1
Findstr /i "Copy Move" %2 &&Set �����ļ����ļ���=1
::Normal
Find /i "At" %2 && (
	Findstr /i "^At " %2 | Find /i /v "Bat" &&Set ���üƻ�����=1
	Find /i "Attrib " %2 &&Set �����ļ�����=1
)
Findstr /i "Assoc Ftype" %2 &&Set �����ļ�����=1
Find /i "Autorun.inf" %2 &&Set ����Windows�Զ�����=1
Findstr /i "Bcdedit Bcdboot Bootcfg" %2 &&Set ��ȡ�������������=1
Find /i "Ca" %2 && (
	Find /i "Call " %2 | Find /v ":" %2 &&Set ���ó���=1
	Find /i "Cacls" %2 &&Set �����ļ�Ȩ��=1
)
Find /i "Format " %2 &&Set ��ʽ������=1
Find /i "Fsutil " %2 &&Set ����Fsutil.exe=1
Find /i "Mountvol" %2 &&Set ���ľ�װ���=1
Findstr /i "Powershell Script Vbs Mshta" %2 &&Set �����������Խű�=1
Find /i "Sc " %2 &&(
	Findstr /i "Sc.query" %2 &&Set ��ѯ�����״̬=1
	Findstr /i "Sc.st" %2 &&(
		Findstr /i "Sc.start" %2 &&Set ��������=1
		Findstr /i "Sc.stop" %2 &&Set ���ķ���״̬=1
	)
	Findstr /i "Sc.con" %2 &&(
		Findstr /i "Sc.config" %2 &&Set ���ķ���=1
		Findstr /i "Sc.control" %2 &&Set ���ķ���״̬=1
	)
	Findstr /i "Sc.create" %2 &&Set ���ķ���=1
	Findstr /i "Sc.lock" %2 &&Set ���ķ���=1
	Findstr /i "Sc.pause" %2 &&Set ���ķ���=1
	Find /i "Schtasks" %2 &&Set ���üƻ�����=1
)
Find /i "Shutdown " %2 &&Set ����Shutdown.exe=1
Find /i "St" %2 && (
	Find /i "Start " %2 &&Set ���ó���=1
	Find /i "Subst " %2 &&Set ��������������=1
)
Findstr /i "Systeminfo" %2 &&Set ��ȡWindowsϵͳ��Ϣ=1
Find /i "Ta" %2 && (
	Find /i "Takeown " %2 &&Set ��ȡ�ļ�����Ȩ=1
	Find /i "Tasklist " %2 &&Set �г�����=1
	Find /i "Taskkill " %2 &&Set ��������=1
)
Find /i "Tskill" %2 &&Set ��������=1
::More
Find "%%" %2 && (
	Findstr /i "%%Temp%% %%Tmp%%" %2 &&Set ʹ����ʱ�ļ�=1
	Findstr /i "%%Systemroot%% %%Windir%%" %2 &&Set ����Windowsϵͳ�ļ���=1
	Findstr /i "%%ProgramFiles" %2 &&Set ����ProgramFiles�ļ���=1
)
Find /i "Arp" %2 && (
	Find /i "Arp -a" %2 &&Set ���ĵ�ַ����Э��=1
	Find /i "Arp -d" %2 &&Set ���ĵ�ַ����Э��=1
	Find /i "Arp -s" %2 &&Set ��ȡ��ַ����Э��=1
)
Find /i "Net" %2 && (
	Find /i "Net Pause " %2 &&Set ����Windows����=1
	Find /i "Net Share $" %2 &&Set �����ļ�����=1
	Find /i "Net Stop " %2 &&Set ����Windows����=1
	Find /i "Net Start " %2 &&Set ����Windows����=1
	Find /i "Net User " %2 &&Set ����Windows�û�=1
)
Find /i "Reg" %2 && (
	Findstr /i "Reg.query " %2 &&Set �鿴ע�����Ŀ��Ϣ=1
	Findstr /i "Reg.add" %2 &&Set ����ע�����Ŀ��Ϣ=1
	Findstr /i "Reg.delete" %2 &&Set ɾ��ע�����Ŀ��Ϣ=1
	Findstr /i "Reg.copy" %2 &&Set ����ע�����Ŀ��Ϣ=1
	Findstr /i "RegEdit " %2 &&Set ����ע�����Ŀ��Ϣ=1
	Findstr /i "Regini" %2 &&Set ����ע���Ȩ��=1
)
Find /i "Windows" %2 && (
	Find /i "Microsoft\Windows\Start Menu\Programs\Startup" %2 &&Set Windows��������=1
	Find /i "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" %2 &&Set Windows��������=1
	Find /i "%HOMEDRIVE%\Windows\" %2 &&Set ����Windowsϵͳ�ļ���=1
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