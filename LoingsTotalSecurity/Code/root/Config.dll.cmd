@(
	Echo off
	If "%~1"=="" Goto :Eof
	Goto :LTS-%*
)

:LTS-Config
(
Cls
Echo.  Loings Total Security          ����
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.               S.        ��ȫ��������
Echo.                           ���ط�����ϵ��������Ȩ������������������ȡ�
Echo.
Echo.               U.        ���ҷ���������
Echo.                           �������ҷ������ֶ����£������Զ����¡�
Echo.
Echo.               C.        �������ļ�
Echo.                           ��������������Ļ����ļ�����ʱ�ļ���
Echo.
Echo.               R.        ���Ի�
Echo.                           �Զ��崰����ʽ����ɫ�ȡ�
Echo.
Echo.               A.        ����
Echo.                           �鿴����汾���鿴����HASHʶ���汾��
Echo.
Echo.
Echo.  B. ����
)
Choice /c SUCRAB /n /m ^>ѡ��
Set "SetData2=%Errorlevel%"
(
	If "%SetData2%"=="6" Goto :Eof
	If "%SetData2%"=="5" Start "" "Modules\About.cmd"
	If "%SetData2%"=="4" Goto :LTS-Config.Color
	If "%SetData2%"=="1" Call SafetyCenter.dll.cmd
	If "%SetData2%"=="2" Call SafetyCenter.dll.cmd OSU
	If "%SetData2%"=="3" Call Clear.dll.cmd
	Goto :LTS-Config
)
Goto :LTS-Config

:LTS-Config.Color
(
Cls
Echo.  Loings Total Security          ����
Echo. _______________________________________________________________________________________________________
Echo.
Echo.               ����ɫ
Echo.
Echo.
Echo.                              N.       Ĭ�ϡ���F3��
Echo.
Echo.                              S.       ����ϵͳ��
Echo.
Echo.                              A.       ����ʱ���Զ�������ɫ����F3,73,08��
Echo.
Echo.                              D.       ��ɫ����08��
Echo.
Echo.                              L.       ��ɫ����F0��
Echo.
Echo.                              H.       Hacker����0B��
Echo.
Echo.
Echo.
Echo.
Echo.  B. ����
)
Choice /c NSADLHB /n /m ^>ѡ��
Set "SetData=%Errorlevel%"
(
	If "%SetData%"=="7" Goto :LTS-Config
	Echo.Set "ColorNum=%SetData%">"%Loings.FileName.Data%\Color.bat"
	Call Config.dll.cmd Set.Color
	Goto :LTS-Config
)

:LTS-Set.Color
Cd /d "%~dp0"
Set "ColorNum="
If exist "Data\Color.bat" Call "Data\Color.bat"
If not defined ColorNum (
	Color F3
	Goto :Eof
)
For %%a in (1:F3 4:08 5:F0 6:0B) do (
	For /f "tokens=1,2 delims=:" %%b in ("%%a") do (
		If "%ColorNum%"=="%%b" (
			Color %%c
			Goto :Eof
		)
	)
)
If "%ColorNum%"=="3" (
	If %Time:~0,2% GEQ 23 (
		Color 08
	) else If %Time:~0,2% GEQ 18 (
		Color 73
	) else If %Time:~0,2% GEQ 6 (
		Color F3
	) else Color 08
	Goto :Eof
)
If "%ColorNum%"=="2" Color >nul 2>nul
Goto :Eof

:LTS-Get.Info
If exist "Registry\SafetyCenter\ActiveDefense\True.cmd" (
    Set "LTS-SC-AD-R=True"
) else (
    Set "LTS-SC-AD-R=False"
)
If exist "Registry\SafetyCenter\RuntimeProtect\True.cmd" (
    Set "LTS-SC-RP-R=True"
) else (
    Set "LTS-SC-RP-R=False"
)
Set YNI=δ
If "%LTS-SC-AD-R%"=="True" If "%LTS-SC-RP-R%"=="True" Set YNI=��
If exist "Modules\LibVer.cmd" Call "Modules\LibVer.cmd"
If exist "Modules\ProVer.cmd" Call "Modules\ProVer.cmd"
Set /A "TL=%LocalVirusLibNum%+%LocalHashLibNum%" 2>nul
Goto :Eof
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS ȫ���ܰ�ȫ��װ'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=55bd38e5b187dc7cab051ba6223dc17090d11df312785f5562dcd0d11d187866'
Set LOINGS-SA_VerCode=6da77ef838c27a5d49c28be405f71223153c392323817748de59da0d628d1091'
