@Echo off
Set "RA=RecoveryArea\$~@DangerousProcedure.{S-1-5-21-3735454642}"	%=������·��=%

:D
(
Takeown /r /d y /f %1 >Nul 2>Nul			%=��ȡ����Ȩ=%
Echo.Y| Cacls %1 /t /c /g %Username%:F >Nul 2>Nul	%=��ȡ��ȫ����Ȩ��=%
Taskkill /f /im %~nx1 >nul 2>nul			%=����ռ��=%
Xcopy /y /c "%~1" "%RA%\" >nul 2>nul			%=���Ƶ�������=%
)
::�������
For /f %%a in ('Cscript //nologo "%~dp0Modules\GUID.vbs"') do (
	Ren "%RA%\%~nx1" "%%a.ra" >nul 2>nul
	Echo.%%a.ra %~f1 >>"%RA%\FilesImage.fi"
)

:DF1
::ɾ���ļ�
(
Del /F /Q %P% "%~1"
Del /F /S /Q %P% "%~1\*.*"
Del /F /A /Q %P% "\\?\%~1"
Del /F /Q /A:S %P% "\\?\%~1"
Del /F /Q /A:L %P% "\\?\%~1"
Del /F /Q /A:R %P% "\\?\%~1"
Del /F /Q /A:H %P% "\\?\%~1"
Del /F /Q /A:I %P% "\\?\%~1"
Del /F /Q /A:A %P% "\\?\%~1"
) >Nul 2>Nul

:DF2
::ɾ���ļ���
(
Del /S /F /Q %P% "%~1\*.*" >Nul 2>Nul
Rd /S /Q %1 2>Nul
Set "Data=%~1"
)
(
Rd /S /Q "%Data:~0,2%\\%Data:~2,500%\\"
Rd /S /Q "\\?\%~1"
Rd /S /Q "\\?\%~1\\"
) >Nul 2>Nul

:Eof
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS ȫ���ܰ�ȫ��װ'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=5210eb8324ebb7f50e07da9f70daff45c4ac57daf5b5838cb13d98d20c9b39f4'
Set LOINGS-SA_VerCode=a06228122bf2e6cafee4a1ac609a7a20203263c258eb16f0b7ac426e29063157'
