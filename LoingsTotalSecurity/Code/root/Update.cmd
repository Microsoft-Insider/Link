@(
	Echo off
	Cd /d "%~dp0"
	Set "DLR=cscript /nologo Modules\multiDl.vbs"		%=Downloader=%
	Set "SLO=https://hacksoft.icoc.me/col.jsp?id=114"       %=Server_Link=%
	Set "RAR=Modules\Rar.exe x -y -mt2"			%=WinRAR_Path=%
	Set "SelfVer=3"						%=Self_Version=%
	Set "GKW=%~1"
	If exist "Variable\Run.Info.3.bat" Call Variable\Run.Info.3.bat
)
Set "LSN="&Set "PSN="
Taskkill /f /pid %LTS.Run.Process.Id.OS% >nul 2>nul
If exist "Acl.Unlock.dll.cmd" Call Acl.Unlock.dll.cmd >nul 2>nul
Del /q "*Up.rar" >nul 2>nul
If /i "%~1"=="User" Goto :User
:First
::��ȡ�������ϵ���Ϣ
(
	Del /q "LTSVer.cmd" >nul 2>nul
	Call Download.dll.cmd LTSVer LTSVer.cmd
	Call LTSVer.cmd
	Call Modules\LibVer.cmd			%=���ذ汾=%
	Call Modules\ProVer.cmd			%=���ذ汾=%
)
Goto :%GKW%

:Auto
Call :Library
Call :Program
Call :Self
Start /i /low /min "Loings Total Security" %Windir%\system32\cmd.exe /d /c Call "%~dp0OwnSafe.cmd"
Goto :Exit

:Library
If "%Force1%"=="0" (					%=�ж��Ƿ����=%
	If %ServerVirusLibNum% LEQ %LocalVirusLibNum% (
		If %ServerHashLibNum% LEQ %LocalHashLibNum% Goto :Eof
	)
) else Set "LSN=1"
Call Download.dll.cmd LibUp LibUp.rar >nul 2>nul	%=���ظ���=%
%RAR% LibUp.rar .\ >nul 2>nul				%=��ѹ����=%
Goto :Eof

:Program
If "%Force2%"=="0" (					%=�ж��Ƿ����=%
	If %ServerVersionBuild% LEQ %LocalVersionBuild% Goto :Eof
) else Set "PSN=1"
Call Download.dll.cmd ProUp ProUp.rar >nul 2>nul	%=���ظ���=%
%RAR% ProUp.rar .\ >nul 2>nul				%=��ѹ����=%
Goto :Eof

:Self
If %UpSelfVer% LEQ %SelfVer% Goto :Eof			%=�ж��Ƿ���Ҫ���Ҹ���=%
Call Download.dll.cmd UpSelf UpSelf.rar >nul 2>nul		%=���ظ���=%
Echo.@Echo off&Cd /d "%%~dp0"		>Update_tmp.cmd
Echo.%RAR% UpSelf.rar .\ ^>nul 2^>nul	>>Update_tmp.cmd
Echo.Del /q "Update_tmp.cmd"^&Exit	>>Update_tmp.cmd
(
Start /min /wait Update_tmp.cmd
Start /i /low /min "Loings Total Security %Random%" %Windir%\system32\cmd.exe /d /c Call "%~dp0OwnSafe.cmd"
Exit
)

:RunLink
Start "" "%SLO%"			%=�����ѷ����汾�򿪹�������=%
Exit

:User
Call "Modules\NormalRun.cmd"
Title Loings Total Security
(
Cls
Echo.  Loings Total Security          ����
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.
Echo.        ���ڼ�����...
Echo.
)
(
	Del /q "LTSVer.cmd"
	Call Download.dll.cmd LTSVer LTSVer.cmd 
	Call LTSVer.cmd
) >nul 2>nul
Call Modules\LibVer.cmd			%=���ذ汾=%
Call Modules\ProVer.cmd			%=���ذ汾=%
Set LFN=0
Set PFN1=0
Set PFN2=0
If "%Force1%"=="0" (					%=�ж��Ƿ����=%
	If %ServerVirusLibNum% LEQ %LocalVirusLibNum% (
		If %ServerHashLibNum% LEQ %LocalHashLibNum% Set "LFN=1"&&Goto :U_UP
	)
)
(
Cls
Echo.  Loings Total Security          ����
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.
Echo.        ���ڸ���������...
Echo.
Echo.
Echo.          %UL1%
Echo.          %UL2%
Echo.          %UL3%
Echo.          %UL4%
Echo.          %UL5%
)
Call :Library
:U_UP
If "%Force2%"=="0" (					%=�ж��Ƿ����=%
	If %ServerVersionBuild% LEQ %LocalVersionBuild% Set PFN1=1
)
If %UpSelfVer% LEQ %SelfVer% Set "PFN2=1"
If "%LFN%"=="1" If "%PFN1%"=="1" If "%PFN2%"=="1" Goto :U_N
If "%PFN1%"=="1" If "%PFN2%"=="1" Goto :U_F
(
Cls
Echo.  Loings Total Security          ����
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.
Echo.        ���ڸ��²�Ʒ...
Echo.
Echo.
Echo.          %UP1%
Echo.          %UP2%
Echo.          %UP3%
Echo.          %UP4%
Echo.          %UP5%
)
Call :Program
Call :Self
:U_F
(
Cls
Echo.  Loings Total Security          ����
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.
Echo.        ��������ɡ�
Echo.
Start /i /low /min "Loings Total Security" %Windir%\system32\cmd.exe /d /c Call "%~dp0OwnSafe.cmd"
Timeout /t 3 >nul
Exit
)
:U_N
(
Cls
Echo.  Loings Total Security          ����
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.
Echo.        ��ĳ��������µġ�
Echo.
Start /i /low /min "Loings Total Security" %Windir%\system32\cmd.exe /d /c Call "%~dp0OwnSafe.cmd"
Timeout /t 3 >nul
Exit
)
