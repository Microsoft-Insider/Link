If /i "%~1"=="Auto" Goto :Auto
If /i "%~1"=="User" Goto :User
Exit

:User
(
Cls
Echo.  Loings Total Security          ɨ��
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.     �ṩһ���ļ�·����ɨ��
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
Echo.  Loings Total Security          ɨ��
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.        ����ɨ��������
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.          ����ɨ�裺"%SP.Path%"
Echo.
)
Set /p=".           ��ʼɨ�� " <nul
Set "B=False"
Set "Warnning.Level.Num=0"
Set "Safe=��ȫ��"
Set /p="��ϣ���� " <nul
Call ScanHash.dll.cmd "%SP.Path%"					%=ɨ������=%
If "%B%"=="True" (
	Echo. ��ϣ�����⵽��в
	Set "Safe=������в���Ѵ���"
	Call "%~dp0Deleter.cmd" "%SP.Path%"			%=ǿ��ɾ�����ƶ���������=%
	Goto :UE
)
Set /p="�ѿǽ��� " <nul
Call Shell.dll.cmd "%SP.Path%" >nul 2>nul				%=�����ѿ�=%
Call ActiveDefenseIni.cmd >nul 2>nul					%=DEBUG=%
Set /p="Ȩ�޷��� " <nul
Call Permissions.dll.cmd Ver "%~dp0Temp\decrypt_code.tmp" >nul		%=���Ȩ��Ҫ��=%
Cd /d "%~dp0"							%=�л�����Ŀ¼=%
Set /p="��Ϊ���� " <nul
Call "%~dp0Variable\OutSetVar.tmp.bat"				%=��ȡ��Ϊ�б�=%
Call "%~dp0BehavioralLib\Tick.1.cmd" "%~dp0Temp\decrypt_code.tmp"	%=������Ϊ=%
If "!Warnning.Level.Num!"=="" Echo.Not Found Variable. - Warnning.Level.Num = ? &&Pause
If !Warnning.Level.Num! GEQ 8 (
	Set "B=True"
) else (
	Set "B=!B!"
)
If "!B!"=="True" (
	Echo. ���������⵽��в
	Set "Safe=������в���Ѵ���"
	Call "%~dp0Deleter.cmd" "!SP.Path!"				%=ǿ��ɾ�����ƶ���������=%
)
Set /p="ɨ����� " <nul

:UE
(
Cls
Echo.  Loings Total Security          ɨ��
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.        ɨ�������
Echo.
Echo.
Echo.
Echo.               �ļ�!Safe!
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
Echo.�����������
Pause >nul
Goto :Eof
)
Goto :Eof

:Auto
Cls
Echo.  Loings Total Security          ɨ��
Echo. _______________________________________________________________________________________________________
Echo.
Echo.     ѡ��һ�����̽���ɨ��
Echo.
Wmic logicaldisk where drivetype=3 get deviceid 2>nul|Find ":" >Temp\Scan.r.tmp
Wmic logicaldisk where drivetype=2 get deviceid 2>nul|Find ":" >>Temp\Scan.r.tmp
Wmic logicaldisk where drivetype=4 get deviceid 2>nul|Find ":" >>Temp\Scan.r.tmp
For /f %%a in (Temp\Scan.r.tmp) do (
	Echo.          %%a
)
Echo.
Echo.  0. ����
Choice /C abcdefghijklmnopqrstuvwxyz0 /N /M ">ѡ��"
If Errorlevel 27 Goto :Eof
Echo.Loading...
For %%a in (
	26:Z 25:Y 24:X 23:W 22:V 21:U 20:T 19:S 18:R 17:Q
	16:P 15:O 14:N 13:M 12:L 11:K 10:J 9:I 8:H 7:G 6:F
	5:E 4:D 3:C 2:B 1:A
) do For /f "tokens=1,* delims=:" %%b in ("%%a") do (
	If "%Choice%"=="%%b" (
		Set "D=%%c:"
		Goto Search
	)
)
Goto :Auto
:Search
If not exist "%D%" Goto :Auto
(
Cls
Echo.  Loings Total Security          ɨ��
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.               H.        ����ɨ�裨Auto in 5s��
Echo.                           ���ù�ϣֵ����ƥ��ɨ�衣
Echo.
Echo.               P.        ��ȫɨ��
Echo.                           ������Ϊ������������ɨ�衣
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
Echo.  B. ����
)
Choice /m ">ѡ��" /n /c HPB /t 5 /d H
Set "SetData=%Errorlevel%"
(
If "%SetData%"=="1" Set "Scan.type=Hash"
If "%SetData%"=="2" Set "Scan.type=Beha"
If "%SetData%"=="3" Goto :Auto
)

(
Cls
Echo.  Loings Total Security          ɨ��
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.        ����׼��ɨ��
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
::ɾ������
Del /f /q Temp\*.lts >nul 2>nul
::��ȡȫ�̵�������·��
If exist "%D%\" (
	Dir /a /b /s "%D%\*.bat" "%D%\*.cmd" >>Temp\Scan.Path.lts 2>nul
)
::Debug
Find /v "%~dp0" <"Temp\Scan.Path.lts"|Find /v "Ŀ¼����"|Findstr /v "& | ) ( > <"|Findstr ":" >Temp\Scan.Path.R.lts
SetLocal EnableDelayedExpansion
Set "Num=0"&Set "Num2=0"&Set "Num3=0"&Set "Tot=0"
::��ȡ�ļ�����
For /f %%a in (Temp\Scan.Path.R.lts) do (
	Set /a "Tot+=1"
)
If "%Scan.type%"=="Hash" Goto :HashScan
::ɨ���ļ�
Goto Scan.%Scan.type%
:Scan.Hash
For /f "tokens=1*" %%a in (Temp\Scan.Path.R.lts) do (
	Set "PPath=%%a"
	If not "%%b"=="" Set "PPath=%%a %%b"
	Call :Show "!PPath!" !Num! %=UI=%
	Call ScanHash.dll.cmd "!PPath!"		%=ɨ������=%
	If "!B!"=="True" (
		Set "Point!Num2!=!PPath!"	%=�����⵽��в������·�����沢������в��=%
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
	Call Permissions.dll.cmd Ver "!PPath!"			%=ɨ������=%
	Cd /d "%~dp0"						%=�л�����Ŀ¼=%
	Call "%~dp0Variable\OutSetVar.tmp.bat"			%=��ȡ��Ϊ�б�=%
	Call "%~dp0BehavioralLib\Tick.1.cmd" "!PPath!"		%=������Ϊ=%
	If !Warnning.Level.Num! GEQ 8 (
		Set "B=True"
	) else (
		Set "B=False"
	)
	If "!B!"=="True" (
		Set "Point!Num2!=%%a"	%=�����⵽��в������·�����沢������в��=%
		Set /a "Num2+=1"
	)
	Set /a Num+=1
)
Goto :InWarn

::��в����
:InWarn
For /l %%a in (0,1,!Num2!) do (
	If not defined Point%%a Goto :End
	Call :Op "!Point%%a!" %%a %=UI=%
	Call "Deleter.cmd" "!Point%%a!"	%=ǿ��ɾ�����ƶ���������=%
)
::����
Goto :End

:HashScan
Call "%~dp0Scan_B.cmd"
Goto :Eof

:Show
(
Cls
Echo.  Loings Total Security          ɨ��
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.        ����ɨ��������
Echo.
Echo.               ��ɨ�� "%~2" ���ļ�
Echo.               �ѷ��� "!Num2!" ����в
Echo.               �� "!Tot!" ���ļ�
Echo.
Echo.
Echo.          ����ɨ�裺"%~1"
Goto :Eof
)

:Op
(
Cls
Echo.  Loings Total Security          ɨ��
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.        �����Զ�������в
Echo.
Echo.
Echo.               �ѷ��� "!Num2!" ����в
Echo.               ���ڴ���� "%~2" ��
Echo.
Echo.
Echo.          ���ڴ���"%~1"
Goto :Eof
)

:End
(
Cls
Echo.  Loings Total Security          ɨ��
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.        ɨ�������
Echo.
Echo.
Echo.               �ѷ��ֲ����� "!Num2!" ����в��
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
Echo.�����������
Pause >nul
Goto :Eof
)
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS ȫ���ܰ�ȫ��װ'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=668d830ce501bf962fa76b843258e3f0620a3e210d7db0deeeb0add8b78194bf'
Set LOINGS-SA_VerCode=88570763fd795e4219b714b74c2a94bc767b79666fe3962977b2ffa152127586'
