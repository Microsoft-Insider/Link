@Echo off

:Tools
(
Cls
Echo.  Loings Total Security          ����
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.               1.        �ļ�ǿ��ɾ����
Echo.
Echo.               2.        ��ϣֵ��ȡ����
Echo.
Echo.               3.        CMD���⻯������
Echo.
Echo.               4.        Loings������ǩ��ʶ��
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
Choice /c 1234B /n /m ^>ѡ��
Set "SetData=%Errorlevel%"
(
	If "%SetData%"=="1" Start Tools\Deleter\DeleterUI.cmd
	If "%SetData%"=="2" Start Tools\HashGetTool.cmd
	If "%SetData%"=="3" Start Tools\CMDSV\#TSC_SV.cmd
	If "%SetData%"=="4" Start Tools\DigitalSignature.cmd
	If "%SetData%"=="5" Goto :Eof
	Goto :Tools
)
Goto :Eof
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS ȫ���ܰ�ȫ��װ'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=468cc51310d0de36f6b2b420f0878fd2782c947d4bd72e32cdc2e010963abc82'
Set LOINGS-SA_VerCode=68d24f472bfc41fd784d6063784745c7a3662aa45513588992e59ece259f120c'
