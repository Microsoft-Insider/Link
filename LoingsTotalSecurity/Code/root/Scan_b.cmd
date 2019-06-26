@Echo off
::�ĵȷ�
Del /f /q "%~dp0Temp\One.lts" "%~dp0Temp\Two.lts" "%~dp0Temp\Three.lts" "%~dp0Temp\Four.lts" >nul 2>nul
Set /a STot=%Tot%/4
Set /a Three=%STot%*3
Set /a Two=%STot%*2
Set One=%STot%
Set A=0
For /f "tokens=1*" %%a in (Temp\Scan.Path.R.lts) do (
	If !A! GEQ %Three% (
		Echo.%%a %%b >>"%~dp0Temp\Four.lts"
	) else If !A! GEQ %Two% (
		Echo.%%a %%b >>"%~dp0Temp\Three.lts"
	) else If !A! GEQ %One% (
		Echo.%%a %%b >>"%~dp0Temp\Two.lts"
	) else Echo.%%a %%b >>"%~dp0Temp\One.lts"
	Set /a A+=1
)

Echo.Set PointData=True>temp.bat

If "%Scan.type%"=="Hash" (
	Copy /b Library\Lib.SHA256_1.vsh + temp.bat Library\OneLib.SHA256_1.vsh
	Copy /b Library\Lib.SHA256_1.vsh + temp.bat Library\TwoLib.SHA256_1.vsh
	Copy /b Library\Lib.SHA256_1.vsh + temp.bat Library\ThreeLib.SHA256_1.vsh
	Copy /b Library\Lib.SHA256_1.vsh + temp.bat Library\FourLib.SHA256_1.vsh
) >nul 2>nul

Del /q "%Loings.FileName.Registry%\SafetyCenter\ActiveDefense\True.cmd" >nul 2>nul
Start /min RunScan.dll.cmd One
Timeout /t 3 >nul
Start /min RunScan.dll.cmd Two
Timeout /t 3 >nul
Start /min RunScan.dll.cmd Three
Timeout /t 3 >nul
Start /min RunScan.dll.cmd Four
Timeout /t 5 >nul
Echo.LTS REG>"%Loings.FileName.Registry%\SafetyCenter\ActiveDefense\True.cmd"

(
Set Scaned=0
Set Killed=0
Set WarnP=0
Set Doing=���ڿ�ʼɨ��
Set ODoing=���ڿ�ʼ����
)

:Show
(
Cls
Echo.  Loings Total Security          ɨ��
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.        ����ɨ��������
Echo.
Echo.               ��ɨ�� "!Scaned!" ���ļ�
Echo.               �ѷ��� "!WarnP!" ����в
Echo.               �� "!Tot!" ���ļ�
Echo.
Echo.
Echo.          ����ɨ�裺"!Done!"
Timeout /t 1 >nul
)
	Call Temp\One.run.bat 2>nul
	Call Temp\Two.run.bat 2>nul
	Call Temp\Three.run.bat 2>nul
	Call Temp\Four.run.bat 2>nul
	Set /a "Scaned=%ScanedOne%+%ScanedTwo%+%ScanedThree%+%ScanedFour%" 2>nul
	Set /a "Scaned2=%ScanedOne%+%ScanedTwo%+%ScanedThree%+%ScanedFour%+4" 2>nul
	Set /a "WarnP=%WarnPOne%+%WarnPTwo%+%WarnPThree%+%WarnPFour%" 2>nul
If !Scaned2! GEQ !Tot! Goto :Op
Goto :Show

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
Echo.               �ѷ��� "!WarnP!" ����в
Echo.               ���ڴ���� "!Killed!" ��
Echo.
Echo.
Echo.          ���ڴ���"!ODone!"
Timeout /t 1 >nul
)
	Call Temp\One.run.bat 2>nul
	Call Temp\Two.run.bat 2>nul
	Call Temp\Three.run.bat 2>nul
	Call Temp\Four.run.bat 2>nul
	Set /a "Killed=%KilledOne%+%KilledTwo%+%KilledThree%+%KilledFour%"
	Set /a "Killed2=%KilledOne%+%KilledTwo%+%KilledThree%+%KilledTwo%+4"
	Set /a "WarnP=%WarnPOne%+%WarnPTwo%+%WarnPThree%+%WarnPFour%"
If !Kiiled2! GEQ !WarnP! Goto :End
Goto :Op

:End
Del "Temp\*.run.bat" "Temp\*.lts" >nul 2>nul
Del /s /f /q "One*.*" "Two*.*" "Three*.*" "Four*.*" >nul 2>nul
(
Cls
Echo.  Loings Total Security          ɨ��
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.        ɨ�������
Echo.
Echo.
Echo.               �ѷ��ֲ����� "!WarnP!" ����в��
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
Set LOINGS-SA_PrivateVer=0c0d1d1317444d729064aa65b23fce55329d87a600b1c37f1d8c99bd62a3def5'
Set LOINGS-SA_VerCode=6346b141fe9206183da314f8d3330db1e5cf293b687aa8f28a57f9b2658ebffc'
