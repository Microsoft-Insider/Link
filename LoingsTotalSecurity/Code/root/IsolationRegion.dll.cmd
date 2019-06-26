@(
Echo off
SetLocal EnableDelayedExpansion
Set "Where=RecoveryArea\$~@DangerousProcedure.{S-1-5-21-3735454642}"
Title Loings Total Security
Call "%~dp0Config.dll.cmd" Set.Color
Cd /d "%~dp0"
)

:Top
Set Do=
(
Cls
Echo.  Loings Total Security          隔离区
Echo.
Echo.
Echo.    所有已隔离的文件：
If exist "%~dp0%Where%\FilesImage.fi" For /f "usebackq tokens=1*" %%a in ("%~dp0%Where%\FilesImage.fi") do (
	Echo.     %%b
) else (
	Echo.     没有可恢复的文件。
)
Echo.
Echo.      D Path  永久删除   B Path  还原文件到原目录
Set /p Do=^>输入：
If "!Do!"=="" Goto :Top
If /i "!Do:~0,2!"=="D " Call :D !Do:~2!
If /i "!Do:~0,2!"=="B " Call :B !Do:~2!
Goto :Top
)

:D
For /f "tokens=1*" %%a in ('Find /i "%~1" "%~dp0%Where%\FilesImage.fi"^|Findstr /v "Find"') do (
	Set T=%%a
)
Del /q "%~dp0%Where%\%T%" >nul 2>nul
Find /v /i "%~f1" "%~dp0%Where%\FilesImage.fi" >"%~dp0%Where%\FilesImage.fi.tmp" 2>nul
Findstr "ra" "%~dp0%Where%\FilesImage.fi.tmp" >"%~dp0%Where%\FilesImage.fi.tmp2" 2>nul
Del /q "%~dp0%Where%\FilesImage.fi" "%~dp0%Where%\FilesImage.fi.tmp" >nul 2>nul
Ren "%~dp0%Where%\FilesImage.fi.tmp2" "FilesImage.fi"
Goto :Top

:B
For /f "tokens=1*" %%a in ('Find /i "%~1" "%~dp0%Where%\FilesImage.fi"^|Findstr /v "Find"') do (
	Set T=%%a
)
Xcopy /y /c "%~dp0%Where%\%T%" "%~dp1" >nul 2>nul
Ren "%~dp1%T%" "%~nx1" >nul 2>nul
Del /q "%~dp0%Where%\%T%" >nul 2>nul
Find /v /i "%~f1" "%~dp0%Where%\FilesImage.fi" >"%~dp0%Where%\FilesImage.fi.tmp" 2>nul
Findstr "ra" "%~dp0%Where%\FilesImage.fi.tmp" >"%~dp0%Where%\FilesImage.fi.tmp2" 2>nul
Del /q "%~dp0%Where%\FilesImage.fi" "%~dp0%Where%\FilesImage.fi.tmp" >nul 2>nul
Ren "%~dp0%Where%\FilesImage.fi.tmp2" "FilesImage.fi" >nul 2>nul
Goto :Top
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS 全功能安全套装'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=8af6eea6fab8b0f7afa1ef2e492d09405be5393296a703d1edff3ff2f30873a4'
Set LOINGS-SA_VerCode=98170bbb9102a6adcbb4c0ab00f66d220fcea1b2d1c2cf335a199995c212c130'
