@Echo off&@Goto P
:P
(
Set "S1=%1"
Set "S2=%2"
Set "S3=%3"
Set "S4=%4"
Set "S5=%5"
Set "S6=%6"
Set "S7=%7"
Set "S8=%8"
Set "S9=%9"
Set EW=
Set Error_5932=
)
For /l %%a in (1,1,9) do (
	If /i "!S%%a:~0,1!"=="@" Set EW=0
)
If "%EW%"=="0" Goto E-0

If /i "%S1%"=="CMD" Set EW=1
If /i "%S1:~1,3%"=="CMD" Set EW=1
If "%EW%"=="1" Goto E-1

If /i "%S1%"=="COMMAND" Set EW=2
If /i "%S1:~1,7%"=="COMMAND" Set EW=2
If "%EW%"=="2" Goto E-2

If /i "%~d1"=="%SystemDrive%" Set EW=3
If /i "%~d2"=="%SystemDrive%" Set EW=3
If /i "%~d3"=="%SystemDrive%" Set EW=3

For /l %%a in (1,1,9) do (
	If /i "!S%%a!"=="GOTO" Set EW=4
	If /i "!S%%a!"=="DEL" Set EW=5
	If /i "!S%%a!"=="CALL" Set EW=6
	If /i "!S%%a!"=="START" Set EW=7
	If /i "!S%%a!"=="SET" Set EW=9
	If /i "!S%%a!"=="TSKILL" Set EW=10
	If /i "!S%%a!"=="TASKKILL" Set EW=10
	If /i "!S%%a!"=="TASKLIST" Set EW=11
)

For /l %%a in (3,1,11) do (
	If "%EW%"=="%%a" Goto E-%%a
)

For /l %%a in (0,1,100) do (
	If /i "!CMD_SET:~%%a,1!"=="*" Set EW=8
)
If "%EW%"=="8" Goto E-8

If /i "%S1%"=="SET" If /i "%S2%"=="/P" Set "BL=%S3:%"&&Set EW=9-1
If "%EW%"=="9-1" Goto E-9-1
If "%EW%"=="9" Goto E-9

If /i "%S1%"=="IF" If /i "%S2%"=="not" If /i "%S3%"=="exist" Set EW=L1
If /i "%S1%"=="IF" If /i "%S2%"=="exist" Set EW=L1

If "%EW%"=="" Goto Eof
Set Error_5932=NoRun
Goto E-%EW%


:E-0
Echo.ָ���к��С�@����
Echo.����ƹ���飬��ȥ�������ԡ�
Goto Stop
:E-1
Echo.��ֹʹ�ø�ָ�
Echo.��ָ����ܻ�Ըõ������Σ����
Goto Stop
:E-2
Echo.��ֹʹ�ø�ָ�
Echo.��ָ����ܻ�Ըõ������Σ����
Goto Stop
:E-3
Echo.��ֹʹ�ø�ָ�
Echo.��ָ���漰ϵͳ�̣����ܻ�Ըõ������Σ����
Goto Stop
:E-4
Echo.��GOTO��ָ���ѱ����á�
Goto Stop
:E-5
Echo.����ɾ���ļ���
Echo.�������ȷ�����ļ��Ƿ��ɾ��������ֹ��
Goto End
:E-6
Echo.���������ⲿ����
Echo.���������ʶ�ó�������ֹ��
Goto End
:E-7
Echo.������ⲿ�������վ��
Echo.���������ʶ�ó������վ������ֹ��
Goto End
:E-8
Echo.��������ʹ��ͨ�����*����
Echo.�������ȷ������������ã�����ֹ��
Goto End
:E-9-1
Echo.������ĵĻ�������Ϊ��%S3%����
Echo.�������ȷ���ñ����Ƿ�ɸ��ģ���ֱ�ӡ�Enter����
Goto Eof
:E-9
Echo.������Ļ���������
Echo.�������ȷ���ñ����Ƿ�ɸ��ģ�����ֹ��
Goto End
:E-10
Echo.����������̣�
Echo.�������ȷ�������Ľ��̣�����ֹ��
Goto End
:E-11
Echo.��TASKLIST��ָ���ѱ����á�
Goto Stop

:E-L1
Echo.����̽���ⲿ�ļ���
Echo.�������ȷ��������ĺ������ã�����ֹ��
Goto End

:Stop
Set Error_5932=Stop
Goto Eof
:End
Set Error_5932=NoRun
Goto Eof
:Eof
Set T1=&Set T2=&Set T3=&Set T4=&Set T5=
Set T6=&Set T7=&Set T8=&Set T9=
Set S1=&Set S2=&Set S3=&Set S4=&Set S5=
Set S6=&Set S7=&Set S8=&Set S9=