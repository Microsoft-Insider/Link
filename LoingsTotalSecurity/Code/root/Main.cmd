@(
	Cd /d "%~dp0"
	Call "Modules\NormalRun.cmd"	%=ͨ�ÿ�ͷ=%
	Call "Config.dll.cmd" Set.Color		%=������ɫ=%
	Echo.  Loings Total Security
)
Del "Variable\*.cmd"				%=ɾ���ɵı��ر���=%
(
	Call "SummonVar.dll.cmd"		%=������������=%
	Call "Variable\BasicEnvironment.bat"	%=��ȡ����ֵ=%
	Call "Variable\Links.cmd"		%=��ȡ����ֵ=%
	Call "GetAdmin.dll.cmd" "%~0"		%=��ȡ����ԱȨ��=%
	Set "Random.Point=%Random%"	%=ȡ���ֵ=%
)
::��ȡ����PID
Title Loings Total Security %Random.Point%
For /f "eol=; tokens=2,3* delims=," %%a in ('Tasklist /v /fo csv /fi "IMAGENAME eq cmd.exe" ^| Find "Loings Total Security %Random.Point%"') do (
	Set "LTS.Run.Process.Id=%%a"
)
Set "LTS.Run.Process.Id=%LTS.Run.Process.Id:~1,-1%"
Echo.Set "LTS.Run.Process.Id=%LTS.Run.Process.Id%">"%~dp0Variable\Run.Info.bat"
SetLocal EnableDelayedExpansion
Title Loings Total Security

:LTS-M
Call Config.dll.cmd Set.Color
Call Config.dll.cmd Get.Info
(
Cls
Echo.  Loings Total Security          ��ҳ
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.          R.        ɨ�����ĵ���                                          T.     ��ȫ����
Echo.                  
Echo.                      �Զ�������ɨ��˵����ϵ����������                O.     ��ȫ����
Echo.
Echo.                                                                          U.     ����
Echo.          S.        ɨ��������
Echo.                                                                          C.     ����
Echo.                      �ṩ�˵����ϵ�һ��λ���Խ���ɨ�衣
Echo.                                                                          E.     �ر�
Echo.
Echo.          A.        �Զ��޸�
Echo.                                                                          %LocalVersion%^(Build%LocalVersionBuild%^)
Echo.                      �Զ�ɨ�����ױ����õ�©�����޸���                    ��ȫ����%YNI%��ȫ����
Echo.                                                                          ����������%TL%
Echo.
Echo.
Echo.
)
Choice /c RSATOUCE /n /m ^>ѡ��
Set "SetData=%Errorlevel%"
(
	If "%SetData%"=="1" Call Scan.cmd Auto
	If "%SetData%"=="2" Call Scan.cmd User
	If "%SetData%"=="3" Call Modules\AutoScanFix.cmd
	If "%SetData%"=="4" Call Tools.cmd
	If "%SetData%"=="5" Call SafetyCenter.dll.cmd
	If "%SetData%"=="6" Start Update.cmd User
	If "%SetData%"=="7" Call Config.dll.cmd Config
	If "%SetData%"=="8" Exit
	Goto :LTS-M
)
Goto :LTS-M
Exit
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS ȫ���ܰ�ȫ��װ'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=d9f0d3c9d88e0e28853835e694696f5ebf2b7ef8628aa3e3dc7fa63dcbbf492d'
Set LOINGS-SA_VerCode=fc29b633926de821b09a0e82a8f452658aa7b15bfd5568ab6e7d5735cf1e74c3'
