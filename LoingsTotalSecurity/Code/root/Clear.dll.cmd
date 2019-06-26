@(
	Echo off
	Cd /d "%~dp0"
	If /i "%~1"=="MgrList" Goto :MgrList
)
(
Cls
Echo.  Loings Total Security          设置
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo. 
Echo.                           正在清理...
Echo.
)
For %%a in (
	LTSVer.cmd *.rar Temp\*.tmp Temp\*.txt
	 Temp\*.lts Temp\*.hash Temp\*.run.bat
	 Variable\OutSetVar.tmp.bat temp.* tmp.*
) do (
	Del /q "%%a" >nul 2>nul
)
(
Cls
Echo.  Loings Total Security          设置
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo. 
Echo.                           清理完成。
Echo.
)
Timeout /t 3 >nul
Goto :Eof

:MgrList
(
Cls
Echo.  Loings Total Security          设置
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo. 
Echo.                           即将打开信任程序列表，您可执行添加或删除操作。
Echo.
)
Timeout /t 3 >nul
%SystemRoot%\Notepad.exe "%~dp0Data\Perm.bat"
Goto :Eof
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS 全功能安全套装'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=4ab438e396e183923689850f60e6442de6fd42ac083d4ab2aed65a4f1258f1a4'
Set LOINGS-SA_VerCode=e4130931171efcb89438924dee83d28fbaa246af12b68acf14e2986a0a926d6a'
