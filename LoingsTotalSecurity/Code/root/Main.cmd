@(
	Cd /d "%~dp0"
	Call "Modules\NormalRun.cmd"	%=通用开头=%
	Call "Config.dll.cmd" Set.Color		%=界面颜色=%
	Echo.  Loings Total Security
)
Del "Variable\*.cmd"				%=删除旧的本地变量=%
(
	Call "SummonVar.dll.cmd"		%=创建变量环境=%
	Call "Variable\BasicEnvironment.bat"	%=获取变量值=%
	Call "Variable\Links.cmd"		%=获取变量值=%
	Call "GetAdmin.dll.cmd" "%~0"		%=获取管理员权限=%
	Set "Random.Point=%Random%"	%=取随机值=%
)
::获取自身PID
Title Loings Total Security %Random.Point%
For /f "eol=; tokens=2,3* delims=," %%a in ('Tasklist /v /fo csv /fi "IMAGENAME eq cmd.exe" ^| Find "Loings Total Security %Random.Point%"') do (
	Set "LTS.Run.Process.Id=%%a"
)
Set "LTS.Run.Process.Id=%LTS.Run.Process.Id:~1,-1%"
Echo.Set "LTS.Run.Process.Id=%LTS.Run.Process.Id%">"%~dp0Variable\Run.Info.bat"
SetLocal EnableDelayedExpansion
Title Loings Total Security

:LTS-M
Call Config.dll.cmd Set.Color
Call Config.dll.cmd Get.Info
(
Cls
Echo.  Loings Total Security          首页
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.          R.        扫描您的电脑                                          T.     安全工具
Echo.                  
Echo.                      自动搜索并扫描此电脑上的批处理程序。                O.     安全中心
Echo.
Echo.                                                                          U.     更新
Echo.          S.        扫描批处理
Echo.                                                                          C.     设置
Echo.                      提供此电脑上的一个位置以进行扫描。
Echo.                                                                          E.     关闭
Echo.
Echo.          A.        自动修复
Echo.                                                                          %LocalVersion%^(Build%LocalVersionBuild%^)
Echo.                      自动扫描容易被利用的漏洞并修复。                    安全防护%YNI%完全开启
Echo.                                                                          特征总数：%TL%
Echo.
Echo.
Echo.
)
Choice /c RSATOUCE /n /m ^>选择：
Set "SetData=%Errorlevel%"
(
	If "%SetData%"=="1" Call Scan.cmd Auto
	If "%SetData%"=="2" Call Scan.cmd User
	If "%SetData%"=="3" Call Modules\AutoScanFix.cmd
	If "%SetData%"=="4" Call Tools.cmd
	If "%SetData%"=="5" Call SafetyCenter.dll.cmd
	If "%SetData%"=="6" Start Update.cmd User
	If "%SetData%"=="7" Call Config.dll.cmd Config
	If "%SetData%"=="8" Exit
	Goto :LTS-M
)
Goto :LTS-M
Exit
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS 全功能安全套装'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=d9f0d3c9d88e0e28853835e694696f5ebf2b7ef8628aa3e3dc7fa63dcbbf492d'
Set LOINGS-SA_VerCode=fc29b633926de821b09a0e82a8f452658aa7b15bfd5568ab6e7d5735cf1e74c3'
