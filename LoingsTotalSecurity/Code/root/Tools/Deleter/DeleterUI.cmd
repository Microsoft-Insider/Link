@Echo off
@Chcp 936 >Nul
@Title LOINGS Deleter
@Mode con cols=60 lines=30
@Color F3
Cd "%~dp0"
Pushd "%~dp0"
Set "Echo5=Echo.&Echo.&Echo.&Echo.&Echo."
Set TES=True
Set GSD=
Set DSD=
Set P=
Set T=3
If exist Config.info.cmd Call Config.info.cmd
Cls

:Home
Cls
Echo. LOINGS Deleter
Echo.
Echo.
Echo. ��ҳ
Echo.
Echo. __________________________________________________________
Echo.
Echo.      1.  ɾ��ָ���ļ����У�
Echo.
Echo.      2.  ����
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
%Echo5%
%Echo5%
Choice /c 12 /n /m ѡ��
If Errorlevel 2 Goto Config
If Errorlevel 1 Goto Delete
Goto Home

:Delete
Cls
Echo. LOINGS Deleter
Echo.
Echo.
Echo. ����·��
Echo.
Echo. __________________________________________________________
Echo.
Echo. ������·����·����ʽΪ��
Echo.
Echo. Drive:\Paths\Names
Echo.
Echo. ��Ҳ���Գ��Խ��ļ���ק���������С�
Echo.
Echo.        1. ����֧��ͨ�����
Echo.        2. �����Զ�ʶ���ļ����ļ��У�
Echo.        3. �ڲ�֪������ʱ��Ҫɾ��ϵͳ�ļ���
Echo.        4. �����ø߼��������ʱ��
Echo.           (1) �Զ���������ɾ���ļ��Ľ��̣�
Echo.           (2) ������ɾ��ǰִ��Ȩ�޻�ȡ��
Echo.           (3) ������ö��ַ�ʽ����ļ���
Echo.           (4) ���򽫻����·���Ƿ���ȷ��
Echo.
Echo.�������򷵻�
Set string=
Set /p string=·����
Call :S %string%
:S <string>
If "%~1"=="" Goto Home
Start /wait /high "" Deleter.cmd %string%
Goto Delete

:Config
Cls
Echo. LOINGS Deleter
Echo.
Echo.
Echo. ����
Echo.
Echo. __________________________________________________________
Echo.
Echo.      1.  ��ʾ����
Echo.
Echo.      2.  ���ܿ���
Echo.
Echo.      3.  �Զ�ִ��
%Echo5%
%Echo5%
%Echo5%
Echo. B. ����
Choice /c 123B /n /m ѡ��
If Errorlevel 4 Goto Home
If Errorlevel 3 Goto S-3
If Errorlevel 2 Goto S-2
If Errorlevel 1 Goto S-1
Goto Config
::----------------------------------------S-1{Config[1]}----------------------------------------
:S-1
Cls
Echo. LOINGS Deleter
Echo.
Echo.
Echo. ����^> ��ʾ����
Echo.
Echo. __________________________________________________________
Echo.
Echo.      1.  �ļ�ɾ������
Echo.
Echo.      2.  Ȩ�޻�ȡ����
Echo.
Echo.      3.  ɾ��ǰ��ʾȷ��
%Echo5%
%Echo5%
%Echo5%
Echo. B. ����
Choice /c 123B /n /m ѡ��
If Errorlevel 4 Goto Config
If Errorlevel 3 Goto S-1-3
If Errorlevel 2 Goto S-1-2
If Errorlevel 1 Goto S-1-1
Goto Config
:S-1-1
Cls
Echo. LOINGS Deleter
Echo.
Echo.
Echo. ����^> ��ʾ����^> �ļ�ɾ������
Echo.
Echo. __________________________________________________________
Echo.
Echo.      Y.  ���ã�Ĭ�ϣ�
Echo.
Echo.      N.  ����
Echo.
Echo.
%Echo5%
%Echo5%
%Echo5%
Echo. B. ����
Choice /c YNB /n /m ѡ��
If Errorlevel 3 Goto S-1
If Errorlevel 2 Set "DSD=>NUL"&&Goto SetData
If Errorlevel 1 Set "DSD="&&Goto SetData
Goto Config
:S-1-2
Cls
Echo. LOINGS Deleter
Echo.
Echo.
Echo. ����^> ��ʾ����^> Ȩ�޻�ȡ����
Echo.
Echo. __________________________________________________________
Echo.
Echo.      Y.  ���ã�Ĭ�ϣ�
Echo.
Echo.      N.  ����
Echo.
Echo.
%Echo5%
%Echo5%
%Echo5%
Echo. B. ����
Choice /c YNB /n /m ѡ��
If Errorlevel 3 Goto S-1
If Errorlevel 2 Set "GSD=>NUL"&&Goto SetData
If Errorlevel 1 Set "GSD="&&Goto SetData
Goto Config
:S-1-3
Cls
Echo. LOINGS Deleter
Echo.
Echo.
Echo. ����^> ��ʾ����^> ɾ��ǰ��ʾȷ��
Echo.
Echo. __________________________________________________________
Echo.
Echo.      Y.  ����
Echo.
Echo.      N.  ���ã�Ĭ�ϣ�
Echo.
Echo.
%Echo5%
%Echo5%
%Echo5%
Echo. B. ����
Choice /c YNB /n /m ѡ��
If Errorlevel 3 Goto S-1
If Errorlevel 2 Set "P="&&Goto SetData
If Errorlevel 1 Set "P=/P"&&Goto SetData
Goto Config
::----------------------------------------S-2{Config[2]}----------------------------------------
:S-2
Cls
Echo. LOINGS Deleter
Echo.
Echo.
Echo. ����^> ���ܿ���
Echo.
Echo. __________________________________________________________
Echo.
Echo. �߼��������
Echo.
Echo.      Y.  ���ã�Ĭ�ϣ�
Echo.
Echo.      N.  ����
Echo.
Echo.     ���ø߼����������ǿ��ɾ���ļ���
Echo.
Echo.
Echo.
%Echo5%
%Echo5%
Echo. B. ����
Choice /c YNB /n /m ѡ��
If Errorlevel 3 Goto Config
If Errorlevel 2 Set "TES=False"&&Goto SetData
If Errorlevel 1 Set "TES=True"&&Goto SetData
Goto Config
::----------------------------------------S-3{Config[3]}----------------------------------------
:S-3
Cls
Echo. LOINGS Deleter
Echo.
Echo.
Echo. ����^> �Զ�ִ��
Echo.
Echo. __________________________________________________________
Echo.
Echo. �����Զ�ѡ���ʱ��
Echo.
Echo.   Ĭ���Զ�ѡ��Ĭ��ѡ���ʱ����3�룻
Echo.
Echo.   �����ڿ����ֶ�����ȴ���ʱ�䣬��λΪ�룻
Echo.
Echo.   ����Ϊ0ʱ�������Զ�ִ�С�
Echo.
Echo.   ��ǰֵ��%T%
Echo.
%Echo5%
%Echo5%
Echo. B. ����
Set /p TT=���룺
If "%TT%"=="B" Goto Config
Set T=%TT%
Goto SetData
::----------------------------------------Set_Data{Config[Output]}----------------------------------------
:SetData
Echo.Set "GSD=%GSD%">Config.info.cmd
Echo.Set "DSD=%DSD%">>Config.info.cmd
Echo.Set "TES=%TES%">>Config.info.cmd
Echo.Set "T=%T%">>Config.info.cmd
Echo.Set "P=%P%">>Config.info.cmd
Goto Config