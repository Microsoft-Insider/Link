@Echo off
::批处理进程路径获取
::GetPath.dll.cmd PID
Set "Show=%~2"		%=外部调用=%
Wmic process where (processid=%~1) get CommandLine | (
	Findstr "cmd.exe" >"%~dp0Temp\RP.Path.txt"
)
Find /i "Call" "%~dp0Temp\RP.Path.txt">nul 2>nul&&Goto :Next
For /f "usebackq tokens=1,2,3*" %%a in ("%~dp0Temp\RP.Path.txt") do (
	Set "Run.Path.Program.tmp=%%c %%d"
)
Set "Run.Path.Program.tmp=%Run.Path.Program.tmp:"=%"
Call :GetPath "%Run.Path.Program.tmp%"
Del /f /q "%~dp0Temp\RP.*.txt" >nul 2>nul
Goto :NR

:GetPath
Set "Run.Path.Program=%~f1"
Set "program_name=%~nx1"
Set "program_path=%~dp1"
Set Run.Path.Program.tmp=
Goto :Eof

:NR
If /i "%Show%"=="Show" Echo.进程标识：%~1(cmd.exe)   位置：%Run.Path.Program%
If /i "%program_path%"="%~dp0" Goto :Next
If "%Run.Path.Program%"==" " Set "program_path=%USERPROFILE%"
If "%Run.Path.Program%"==" " Goto :Next
If not exist "%Run.Path.Program%" Set "program_path=%USERPROFILE%"
If not exist "%Run.Path.Program%" Goto :Next
Find "%Run.Path.Program%" "%Loings.FileName.Data%\Perm.bat">nul 2>nul&&Goto :Next
Goto :Eof

:Next
Set Sec=True
Goto :Eof
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS 全功能安全套装'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=bd4137b1a10dc9023281cb4054c3979a1fd3faeee56eaf50ac7b2d869648bf03'
Set LOINGS-SA_VerCode=d0e7a4c67666a282158b61e383a63ec82c825f5b1cf44249c626afc0126c9414'
