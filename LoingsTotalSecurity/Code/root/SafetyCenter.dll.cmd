If /i "%~1"=="OSU" Goto :OSU
:Top
(
Cls
Echo.  Loings Total Security          ����
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.               A.        ��������
Echo.                           ������ر���������ģ�顣
Echo.
Echo.               R.        ʵʱ����
Echo.                           ������ر�ʵʱ����ģ�顣
Echo.
Echo.               I.        ������
Echo.                           �鿴�ͻָ����������ļ���
Echo.
Echo.               C.        ���������εĳ���
Echo.                           �����������������εĳ���·���б�
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.  B. ����
)
Choice /c ARICB /n /m ^>ѡ��
Set "SetData=%Errorlevel%"
(
If "%SetData%"=="1" Goto :ActiveDefense
If "%SetData%"=="2" Goto :RuntimeProtect
If "%SetData%"=="3" Start "" "%~dp0IsolationRegion.dll.cmd"
If "%SetData%"=="4" Call Clear.dll.cmd MgrList
If "%SetData%"=="5" Goto :Eof
)
Goto :Top

Rem             ��������
:ActiveDefense
If exist "%Loings.FileName.Registry%\SafetyCenter\ActiveDefense\True.cmd" (
    Set "LTS-SC-AD-R=True"
) else (
    Set "LTS-SC-AD-R=False"
)
If "%LTS-SC-AD-R%"=="True" (
    Set "Echo.put.1=����"
) else (
    Set "Echo.put.1=�ر�"
)
(
Cls
Echo.  Loings Total Security          ����
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.   ������������������������ļ����ǰ��Ӧ�û��˻����ƣ�������Hashɨ�衣
Echo.
Echo.       ��ǰ����������������%Echo.put.1%״̬��
Echo.
Echo.
Echo.               T.        ����
Echo.                           ������������ģ�顣
Echo.
Echo.               F.        ����
Echo.                           �ر���������ģ�顣
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.  B. ����
)
Choice /c TFB /n /m ^>ѡ��
Set "SetData=%Errorlevel%"
If exist "Variable\Run.Info.3.bat" Call Variable\Run.Info.3.bat
Taskkill /f /pid %LTS.Run.Process.Id.OS% >nul 2>nul
If exist "Acl.Unlock.dll.cmd" Call Acl.Unlock.dll.cmd >nul 2>nul
If "%SetData%"=="1" (
    Echo.LTS REG>"%Loings.FileName.Registry%\SafetyCenter\ActiveDefense\True.cmd"
    Reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v Autorun /f /d "%~dp0ActiveDefense.bat" >nul 2>nul
	Echo.Reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v Autorun /f /d "%~dp0ActiveDefense.bat" ^>nul 2^>nul>ActiveDefenseIni.cmd
)
If "%SetData%"=="2" (
    Del /q "%Loings.FileName.Registry%\SafetyCenter\ActiveDefense\True.cmd" >nul 2>nul
    Reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v Autorun /f /d "" >nul 2>nul
	Echo.::>ActiveDefenseIni.cmd
)
Start /i /low /min "Loings Total Security" %Windir%\system32\cmd.exe /d /c Call "%~dp0OwnSafe.cmd"
If "%SetData%"=="3" Goto :Top
Goto :ActiveDefense

Rem             ʵʱ����
:RuntimeProtect
If exist "%Loings.FileName.Registry%\SafetyCenter\RuntimeProtect\True.cmd" (
    Set "LTS-SC-RP-R=True"
) else (
    Set "LTS-SC-RP-R=False"
)
If "%LTS-SC-RP-R%"=="True" (
    Set "Echo.put.1=����"
) else (
    Set "Echo.put.1=�ر�"
)
(
Cls
Echo.  Loings Total Security          ����
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.   ʵʱ������������������ʱ��������������Ϊ����ִ�ж�Ӧ��������Σ������ǰ��ʱ������
Echo.
Echo.       ��ǰ��ʵʱ����������%Echo.put.1%״̬��
Echo.
Echo.
Echo.               T.        ���ã����Ľ��������������Ч��
Echo.                           ����ʵʱ����ģ�顣
Echo.
Echo.               F.        ���ã�����������Ч��
Echo.                           �ر�ʵʱ����ģ�顣
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.  B. ����
)
Choice /c TFB /n /m ^>ѡ��
Set "SetData=%Errorlevel%"
If "%SetData%"=="1" (
    Echo.LTS REG>"%Loings.FileName.Registry%\SafetyCenter\RuntimeProtect\True.cmd"
)
If "%SetData%"=="2" (
    Del /q "%Loings.FileName.Registry%\SafetyCenter\RuntimeProtect\True.cmd"
) >nul 2>nul
If "%SetData%"=="3" Goto :Top
Goto :RuntimeProtect

:OSU
(
Cls
Echo.  Loings Total Security          ����
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.               O.        ���ҷ������Զ�����
Echo.                           ������ر����ҷ���ģ�顣
Echo.
Echo.               U.        �ֶ�����
Echo.                           ������鲢��װ���¡�
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
Choice /c OUB /n /m ^>ѡ��
Set "SetData=%Errorlevel%"
(
If "%SetData%"=="1" Goto :OwnSafe
If "%SetData%"=="2" Start "" "Update.cmd" User
If "%SetData%"=="3" Goto :Eof
)
Goto :OSU

Rem             ���ҷ���
:OwnSafe
If exist "%Loings.FileName.Registry%\SafetyCenter\SelfProtect\True.cmd" (
    Set "LTS-SC-OS-R=True"
) else (
    Set "LTS-SC-OS-R=False"
)
If "%LTS-SC-OS-R%"=="True" (
    Set "Echo.put.1=����"
) else (
    Set "Echo.put.1=�ر�"
)
(
Cls
Echo.  Loings Total Security          ����
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.   ���ҷ�������Loings Total Security���ܶ����������ֺ���
Echo.
Echo.       ��ǰ�����ҷ���������%Echo.put.1%״̬��
Echo.
Echo.
Echo.               T.        ���ã����Ľ��������������Ч��
Echo.                           �������ҷ���ģ�顣
Echo.
Echo.               F.        ���ã�����������Ч��
Echo.                           �ر����ҷ���ģ�顣
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.  B. ����
)
Choice /c TFB /n /m ^>ѡ��
Set "SetData=%Errorlevel%"
If "%SetData%"=="1" (
	Echo.LTS REG>"%Loings.FileName.Registry%\SafetyCenter\SelfProtect\True.cmd"
)
If "%SetData%"=="2" (
	Del /q "%Loings.FileName.Registry%\SafetyCenter\SelfProtect\True.cmd"
	Call Acl.Unlock.dll.cmd >nul 2>nul
) >nul 2>nul
If "%SetData%"=="3" Goto :OSU
Goto :OwnSafe
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS ȫ���ܰ�ȫ��װ'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=67c038e4b49ef9f6d5785457fd699d058edd1eae6d00c5f67eefb27dc80813db'
Set LOINGS-SA_VerCode=5f3e8db4b45695be6adfbe27ae8b9b81d911900df18ebc2b12c48f1c1c57f3e2'
