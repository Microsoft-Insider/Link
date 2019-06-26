@(
	Echo off
	If "%~1"=="" Goto :Eof
	Goto :LTS-%*
)

:LTS-Config
(
Cls
Echo.  Loings Total Security          设置
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.               S.        安全防护中心
Echo.                           开关防护体系、管理授权白名单、管理隔离区等。
Echo.
Echo.               U.        自我防护、更新
Echo.                           配置自我防护，手动更新，调整自动更新。
Echo.
Echo.               C.        清理缓存文件
Echo.                           搜索并清理自身的缓存文件、临时文件。
Echo.
Echo.               R.        个性化
Echo.                           自定义窗口样式、颜色等。
Echo.
Echo.               A.        关于
Echo.                           查看程序版本，查看本地HASH识别库版本。
Echo.
Echo.
Echo.  B. 返回
)
Choice /c SUCRAB /n /m ^>选择：
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
Echo.  Loings Total Security          设置
Echo. _______________________________________________________________________________________________________
Echo.
Echo.               主题色
Echo.
Echo.
Echo.                              N.       默认。（F3）
Echo.
Echo.                              S.       跟随系统。
Echo.
Echo.                              A.       根据时间自动调整颜色。（F3,73,08）
Echo.
Echo.                              D.       暗色。（08）
Echo.
Echo.                              L.       亮色。（F0）
Echo.
Echo.                              H.       Hacker。（0B）
Echo.
Echo.
Echo.
Echo.
Echo.  B. 返回
)
Choice /c NSADLHB /n /m ^>选择：
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
Set YNI=未
If "%LTS-SC-AD-R%"=="True" If "%LTS-SC-RP-R%"=="True" Set YNI=已
If exist "Modules\LibVer.cmd" Call "Modules\LibVer.cmd"
If exist "Modules\ProVer.cmd" Call "Modules\ProVer.cmd"
Set /A "TL=%LocalVirusLibNum%+%LocalHashLibNum%" 2>nul
Goto :Eof
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS 全功能安全套装'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=55bd38e5b187dc7cab051ba6223dc17090d11df312785f5562dcd0d11d187866'
Set LOINGS-SA_VerCode=6da77ef838c27a5d49c28be405f71223153c392323817748de59da0d628d1091'
