@(
	Echo off
	Color F3
	Title Installer
	Mode con cols=80 lines=21
	Set "Str.0=Echo.  Loings Total Securtiy"
	Set "Str.1=Echo. ______________________________________________________________________________"
	SetLocal EnableDelayedExpansion
	Cd /d "%~dp0"
	Cls
)
%Str.0%
%Str.1%
Net session >nul 2>nul || (
	Mshta vbscript:CreateObject^("Shell.Application"^).ShellExecute^("cmd.exe","/c call %~0","","runas",1^)^(window.close^)
	Exit
)
For /f "skip=1 tokens=3 delims= " %%a in  ('"Wmic OS get Caption 2>nul"') do If not "%%a"=="" Set Ver=%%a
If "%Ver%"=="" Goto :Err_2

(
Cls
%Str.0%
%Str.1%
Echo.
Echo.     ��ӭ
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.          ���Ե�...
Echo.
Echo.
)
(
	Rd /s /q "%Temp%\$~LTS_InstallData"
	Md "%Temp%\$~LTS_InstallData"
) >nul 2>nul
(
	Set "Path=!Path!;!Temp!\$~LTS_InstallData"
	Set "InstallData=!Temp!\$~LTS_InstallData"
	Set "Paths=%~dp0LoingsTotalSecurity"
)
Sc config bits start= demand >nul 2>nul
Call :Download Code root/Choice.exe "%Temp%\$~LTS_InstallData\Choice.exe"
Echo.Y| Choice >nul 2>nul
If not "%ErrorLevel%"=="1" Goto :Err_1
(
	Echo.^<script^>
	Echo.var Shell = new ActiveXObject^("Shell.Application"^);
	Echo.var Folder = Shell.BrowseForFolder^(0, "", 0^); //��ʼĿ¼Ϊ������ 
	Echo.new ActiveXObject^('Scripting.FileSystemObject'^).GetStandardStream^(1^).Write^(Folder ? Folder.Self.Path : ""^)[close^(^)];
	Echo.^</script^>
) >"%Temp%\$~LTS_InstallData\Select_Folder.hta"
(
	Call :Download Server LTSVer.cmd "%InstallData%\LTSVer.cmd"
	If exist "%InstallData%\LTSVer.cmd" (
		Call "%InstallData%\LTSVer.cmd"
	) else Goto :Err_1
	Title Installer - Build!ServerVersionBuild!
) >nul 2>nul

:Installer
(
Cls
%Str.0%
%Str.1%
Echo.
Echo.     ��ӭ
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.        ��װ·����"!Paths!"
Echo.
Echo.          C.  ���İ�װ·��
Echo.          N.  ��ʼ��װ
Echo.          E.  ȡ����װ
Echo.
)
Choice /c CNE /n
Set "Choice=%ErrorLevel%"
If "!Choice!"=="1" (
	For /f "delims=" %%a in ('Mshta "%Temp%\$~LTS_InstallData\Select_Folder.hta"') do (
		Set "Paths=%%~aLoingsTotalSecurity"
	)
	If "!%~1:~0,3!"=="::{" (
		Call :MsgBox MsgBox "%txt_s.fold_invalid%"
		Set "Paths="
	)
	If "!Paths!"=="" Set "Paths=%~dp0LoingsTotalSecurity"
	Goto :Installer
) else If "!Choice!"=="2" (
	Goto :Start
) else If "!Choice!"=="3" (
	Rd /s /q "%InstallData%\" >nul 2>nul
	Exit
)

:Start
Call :INSE "���ɰ汾"
If exist !Paths! (
	Call :Err_4
	(
		Call :INSE "ɾ���ɰ汾"
		Takeown /f "!Paths!\*.cmd" /r /d y
		Icacls "!Paths!\*.cmd" /grant %username%:F /t
		Icacls "!Paths!\*.cmd" /grant administrators:F /t
		Rd /s /q "!Paths!\"
	) >nul 2>nul
)
Call :INSE "���ڿ�ʼ"
Md "!Paths!\TestFolder\" >nul 2>nul || Goto :Err_3
Rd /s /q "!Paths!\" >nul 2>nul || Goto :Err_3
Echo.Test>"!Paths!\TestFile" || Goto :Err_3
Del /f /q "!Paths!\TestFile" >nul 2>nul || Goto :Err_3
Call :INSE "���������б� 1/2"
Call :Download Server List.lst "%InstallData%\List.lst"
Call :INSE "���������б� 2/2"
Call :Download Server FolderList.lst "%InstallData%\FolderList.lst"
For %%a in (
	�����ļ��ϴ�1:root/Modules/rar.exe:rar.exe
	2:Launcher.cmd:Launcher.cmd
	3:ReadMe.txt:ReadMe.txt
) do For /f "tokens=1,2,3 delims=:" %%i in ("%%a") do (
	Call :INSE "���������ļ� %%i/3"
	Call :Download Code "%%j" "%InstallData%\%%k"
)
Call :INSE "���ڴ���Ŀ¼"
For /f "usebackq delims=" %%a in ("%InstallData%\FolderList.lst") do (
	Md "%InstallData%\root\%%a\" >nul 2>nul
)
For /f "usebackq delims=" %%a in ("%InstallData%\List.lst") do (
	Set /a "TotalNum+=1"
)
For /f "usebackq delims=" %%a in ("%InstallData%\List.lst") do (
	Set /a "NowNum+=1"
	Call :INSE "���������ļ� !NowNum!/!TotalNum!"
	(
		Set "TempPath=%%~a"
		Set "TempPath=!TempPath:/=\!"
		For /f "delims=" %%b in ("!TempPath!") do (
			Set "TempPath=%%~dpb"
			Set "TempPath=!TempPath:%~dp0=%InstallData%\root\!"
			Set "FileName=%%~nxb"
		)
	)
	Call :Download Code "root/%%~a" "!TempPath!!FileName!"
	If not exist "!TempPath!!FileName!" Goto :Err-1
	If /i "!FileName:~-4!"==".rar" (
		Rar x -y -mt2 "!TempPath!!FileName!" "!TempPath!"
		Del /f /q "!TempPath!!FileName!"
	) >nul 2>nul
)
Call :INSE "�����ƶ��ļ�"
(
	Md "!Paths!\root"
	Xcopy /y /r /h /g /q /c /e "%InstallData%\root\*" "!Paths!\root\"
	Rd /s /q"%InstallData%\root\"
	Move "%InstallData%\Rar.exe" "!Paths!\root\Modules\rar.exe"
	Move "%InstallData%\Launcher.cmd" "!Paths!\"
	Move "%InstallData%\ReadMe.txt" "!Paths!\"
	Copy /y "%InstallData%\Choice.exe" "!Paths!\root\"
) >nul 2>nul
Call :INSE "������������"
(
	Reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v Autorun /f /d "!Paths!\root\ActiveDefense.bat" >nul 2>nul
	Reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v LTS_RuntimeProtect /t reg_sz /d "\"%SystemRoot%\System32\cmd.exe\" /c Start /min /low \"%random%\" \"!Paths!\root\RuntimeProtect.cmd\" Start" /f >nul 2>nul
	Echo.LTS REG>"!Paths!\root\Registry\SafetyCenter\ActiveDefense\True.cmd"
	Echo.Reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v Autorun /f /d "!Paths!\root\ActiveDefense.bat" ^>nul 2^>nul>ActiveDefenseIni.cmd
	Call "!Paths!\root\SummonVar.dll.cmd"
	Call "!Paths!\root\Acl.Lock.dll.cmd"
	Start /low /min "Loings Total Security %random%" "%Windir%\system32\cmd.exe" /d /c "!Paths!\root\RuntimeProtect.cmd"
)
:Finish
(
Cls
%Str.0%
%Str.1%
Echo.
Echo.     ��װ���
Echo.
Echo.
Echo.
Echo.        ʹ��ǰ�����Ķ���װĿ¼�ڵ�"ReadMe.txt"
Echo.
Echo.          O.  ����Loings Security
Echo.          F.  ������װ
Echo.
)
Choice /C OF /N
Set "Choice=%Errorlevel%"
Rd /s /q "%InstallData%\" >nul 2>nul
If "!Choice!"=="1" Start "!Random!" "%Paths%\Launcher.cmd"
If "!Choice!"=="2" Exit
Exit

:INSE
(
Cls
%Str.0%
%Str.1%
Echo.
Echo.     ���ڰ�װ
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.          %~1
Echo.          %~2
Echo.
Goto :Eof
)
Goto :Eof

:Download
Del /q "%~f3" >nul 2>nul
Bitsadmin /transfer !random! /download /priority foreground "https://raw.githubusercontent.com/Microsoft-Insider/Link/master/LoingsTotalSecurity/%~1/%~2" "%~f3" >nul 2>nul
If exist "%~f3" (
	Exit /b 0
) else Exit /b 2

:MsgBox
:cycle
Set msgbox.t1=""""
If not "%~2"=="" (
	Set "msgbox.t1=!msgbox.t1!&""%~2""&vbCrLf"
	Shift /2
	Goto :cycle
)
Mshta vbscript:execute^("msgbox(%msgbox.t1%,64,""%txt_tips%"")(close)"^)
Goto :Eof

:Err_0
(
Cls
%Str.0%
%Str.1%
Echo.
Echo.     Error 0
Echo.&Echo.&Echo.&Echo.&Echo.&Echo.&Echo.
Echo.          ������ֵʧ�ܡ�
Pause >nul
Exit
)
:Err_1
(
Cls
%Str.0%
%Str.1%
Echo.
Echo.     Error 1
Echo.&Echo.&Echo.&Echo.&Echo.
Echo.          �޷����������ļ���
Echo.          ���黥�������ӡ�
Echo.
Echo.
Pause >nul
Exit
)
:Err_2
(
Cls
%Str.0%
%Str.1%
Echo.
Echo.     Error 2
Echo.&Echo.&Echo.&Echo.&Echo.
Echo.          ��ǰ���������ݱ������
Echo.          Windows�汾����֧�֡�
Echo.
Echo.
Pause >nul
Exit
)
:Err_3
(
Cls
%Str.0%
%Str.1%
Echo.
Echo.     Error 3
Echo.&Echo.&Echo.&Echo.&Echo.
Echo.          ��ǰĿ¼�޷���װ��
Echo.          �������װλ�á�
Pause >nul
Exit
)
:Err_4
(
Cls
%Str.0%
%Str.1%
Echo.
Echo.     Error 4
Echo.&Echo.&Echo.&Echo.&Echo.
Echo.          ��⵽�Ѱ�װ��Loings Security��Ʒ��
Echo.          ѡ��һ��ѡ���Լ�����
Echo.
Echo. 
)
Choice /C YN /M ".             ���ǰ�װ"
Set "Choice=%Errorlevel%"
If "!Choice!"=="1" Goto :Eof
If "!Choice!"=="2" Goto :Exit
Goto :Eof
:Sign-LOINGS_4
Set LOINGS-SA_Name=Loings Security Installer'
Set LOINGS-SA_Info=LOINGS��ȫ�����װ����'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=HIGH'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writer=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=cd4a2a9aa53872bf7e60dd2839994719e765163a193c44ea7f7e0d9e52935be2'
Set LOINGS-SA_VerCode=2d8ef0d7703fe9e3326acb980e2828502bc18340b5281b673e3ef5b78cb7751b'
