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
	Call "%~dp0Deleter.cmd" "%SP.Path%"				%=ǿ��ɾ�����ƶ���������=%
	Goto :UE
)
Set /p="�ѿǽ��� " <nul
Call Shell.dll.cmd "%SP.Path%" >nul 2>nul				%=�����ѿ�=%
Call ActiveDefenseIni.cmd >nul 2>nul					%=DEBUG=%
Set /p="Ȩ�޷��� " <nul
Call Permissions.dll.cmd Ver "%~dp0Temp\decrypt_code.tmp" >nul		%=���Ȩ��Ҫ��=%
Cd /d "%~dp0"								%=�л�����Ŀ¼=%
Set /p="��Ϊ���� " <nul
Call "%~dp0Variable\OutSetVar.tmp.bat"					%=��ȡ��Ϊ�б�=%
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
) else If Errorlevel 0 		Echo.Error - ��Ч��ERRORLEVELֵ��
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
Set LOINGS-SA_PrivateVer=07c3b7d5ffa1cfa3a18c86c281bb710797a9c8ffd06270814acb6e2897158b8f'
Set LOINGS-SA_VerCode=0f81b0c34af26fdec49d000ba3b2bf0c344b05dd5d1cdb869b22a5f4559c0bf1'
