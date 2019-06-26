@Echo off
Mode con cols=80 lines=21
Echo.Loading...
Color F3					%=������ɫ=%
Title LOINGS					%=���ñ���=%
Set TODAY=%date:~0,4%%date:~5,2%%date:~8,2%	%=��ȡ����=%
Cd "%~dp0"
Pushd "%~dp0"
Setlocal Enabledelayedexpansion

::API
If not "%~1"=="" Set "Code=%~1"&&Goto Ver
Goto M

Copyright (C) 2019 LOINGS Corporation all rights reserved.

:M
Cls
Echo.
Echo.
Echo. ______________________________________________________________________________
Echo.
Echo. �����ļ�·��
Echo.
Echo.
Echo.
Echo.  [drive:][path]filename
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
Set Code=
Set /p Code= ^>
::DeBug
Call Exp_dll.cmd %Code%
Set "Code=%P_Temp%"
If "%Code%"=="" Goto M
Set P_Temp=
Goto Ver

:Ver
Cls
Echo.
Echo.
Echo. ______________________________________________________________________________
Echo.
Echo.
Echo.  ���Ե�...
Echo.
Echo.     ���ڻ�ȡ��Ϣ
Echo.
Echo.
Echo.
Echo.       SHA256
Certutil -hashfile "%Code%" SHA256|Findstr /v "��ϣ hashfile" >HashSign.Code.tmp
::��ȡ��ϣֵ
For /F "usebackq delims=" %%i in (HashSign.Code.tmp) do Set "Hash.Code=%%i"
::ɾ������
Del /f /q HashSign.Code.tmp >nul 2>nul
::Debug
Set BNum=1
If "%Hash.Code:~2,1%"==" " Goto GetCode

:Back_1
Set "HashFail="
Set Hash.Code2=%Hash.Code%
Echo. �ѻ�ȡ�ļ���ϣֵ
Goto Out

:GetCode
::����Windows7��ͳһ�����ʽ
Set "Hash.Code.part1=%Hash.Code:~0,2%%Hash.Code:~3,2%%Hash.Code:~6,2%%Hash.Code:~9,2%%Hash.Code:~12,2%%Hash.Code:~15,2%%Hash.Code:~18,2%"
Set "Hash.Code.part2=%Hash.Code:~21,2%%Hash.Code:~24,2%%Hash.Code:~27,2%%Hash.Code:~30,2%%Hash.Code:~33,2%%Hash.Code:~36,2%%Hash.Code:~39,2%"
Set "Hash.Code.part3=%Hash.Code:~42,2%%Hash.Code:~45,2%%Hash.Code:~48,2%%Hash.Code:~51,2%%Hash.Code:~54,2%%Hash.Code:~57,2%%Hash.Code:~60,2%"
Set "Hash.Code.part4=%Hash.Code:~63,2%%Hash.Code:~66,2%%Hash.Code:~69,2%%Hash.Code:~72,2%%Hash.Code:~75,2%%Hash.Code:~78,2%%Hash.Code:~81,2%"
Set "Hash.Code.part5=%Hash.Code:~84,2%%Hash.Code:~87,2%%Hash.Code:~90,2%%Hash.Code:~93,2%"
Set "Hash.Code=%Hash.Code.part1%%Hash.Code.part2%%Hash.Code.part3%%Hash.Code.part4%%Hash.Code.part5%"
Goto Back_%BNum%

:Out
If /i "/FeedBack"=="%~2" Goto :Eofs
Cls
Echo.
Echo.
Echo. ______________________________________________________________________________
Echo.
Echo. ��Ϣ
Echo.
Echo.   %Code%
Echo.
Echo.    SHA256��
Echo.      %Hash.Code%
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Pause >nul
Goto M

:Eofs
Cls
Echo.Successfully.
Del /f /q SignSet.cmd >nul 2>nul
For %%a in (PN,LSW,RegVersion,RECE,Hash,EFA) do (
	Echo.Set "%%a=!%%a!">>SignSet.cmd
)
Endlocal
Call SignSet.cmd
Del /f /q SignSet.cmd >nul 2>nul