If /i "%~1"=="OSU" Goto :OSU
:Top
(
Cls
Echo.  Loings Total Security          设置
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.               A.        主动防御
Echo.                           开启或关闭主动防御模块。
Echo.
Echo.               R.        实时防护
Echo.                           开启或关闭实时防护模块。
Echo.
Echo.               I.        隔离区
Echo.                           查看和恢复隔离区的文件。
Echo.
Echo.               C.        管理受信任的程序
Echo.                           管理受主动防御信任的程序路径列表。
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.  B. 返回
)
Choice /c ARICB /n /m ^>选择：
Set "SetData=%Errorlevel%"
(
If "%SetData%"=="1" Goto :ActiveDefense
If "%SetData%"=="2" Goto :RuntimeProtect
If "%SetData%"=="3" Start "" "%~dp0IsolationRegion.dll.cmd"
If "%SetData%"=="4" Call Clear.dll.cmd MgrList
If "%SetData%"=="5" Goto :Eof
)
Goto :Top

Rem             主动防御
:ActiveDefense
If exist "%Loings.FileName.Registry%\SafetyCenter\ActiveDefense\True.cmd" (
    Set "LTS-SC-AD-R=True"
) else (
    Set "LTS-SC-AD-R=False"
)
If "%LTS-SC-AD-R%"=="True" (
    Set "Echo.put.1=开启"
) else (
    Set "Echo.put.1=关闭"
)
(
Cls
Echo.  Loings Total Security          设置
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.   主动防御会在批处理更改您的计算机前响应用户账户控制，并进行Hash扫描。
Echo.
Echo.       当前“主动防御”处于%Echo.put.1%状态。
Echo.
Echo.
Echo.               T.        启用
Echo.                           开启主动防御模块。
Echo.
Echo.               F.        禁用
Echo.                           关闭主动防御模块。
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.  B. 返回
)
Choice /c TFB /n /m ^>选择：
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

Rem             实时防护
:RuntimeProtect
If exist "%Loings.FileName.Registry%\SafetyCenter\RuntimeProtect\True.cmd" (
    Set "LTS-SC-RP-R=True"
) else (
    Set "LTS-SC-RP-R=False"
)
If "%LTS-SC-RP-R%"=="True" (
    Set "Echo.put.1=开启"
) else (
    Set "Echo.put.1=关闭"
)
(
Cls
Echo.  Loings Total Security          设置
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.   实时防护会在批处理读写数量达到警戒值时分析该批处理，并执行对应方案。
Echo.
Echo.       当前“实时防护”处于%Echo.put.1%状态。
Echo.
Echo.
Echo.               T.        启用（更改将在重启程序后生效）
Echo.                           开启实时防护模块。
Echo.
Echo.               F.        禁用（更改立即生效）
Echo.                           关闭实时防护模块。
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.  B. 返回
)
Choice /c TFB /n /m ^>选择：
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
Echo.  Loings Total Security          设置
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.
Echo.               O.        自我防护与自动更新
Echo.                           开启或关闭自我防护模块。
Echo.
Echo.               U.        手动更新
Echo.                           立即检查并安装更新。
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
Echo.  B. 返回
)
Choice /c OUB /n /m ^>选择：
Set "SetData=%Errorlevel%"
(
If "%SetData%"=="1" Goto :OwnSafe
If "%SetData%"=="2" Start "" "Update.cmd" User
If "%SetData%"=="3" Goto :Eof
)
Goto :OSU

Rem             自我防护
:OwnSafe
If exist "%Loings.FileName.Registry%\SafetyCenter\SelfProtect\True.cmd" (
    Set "LTS-SC-OS-R=True"
) else (
    Set "LTS-SC-OS-R=False"
)
If "%LTS-SC-OS-R%"=="True" (
    Set "Echo.put.1=开启"
) else (
    Set "Echo.put.1=关闭"
)
(
Cls
Echo.  Loings Total Security          设置
Echo. _______________________________________________________________________________________________________
Echo.
Echo.
Echo.   自我防护保护Loings Total Security不受恶意批处理侵害。
Echo.
Echo.       当前“自我防护”处于%Echo.put.1%状态。
Echo.
Echo.
Echo.               T.        启用（更改将在重启程序后生效）
Echo.                           开启自我防护模块。
Echo.
Echo.               F.        禁用（更改立即生效）
Echo.                           关闭自我防护模块。
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.  B. 返回
)
Choice /c TFB /n /m ^>选择：
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
Set LOINGS-SA_Info=LOINGS 全功能安全套装'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=addd997725c6bff0f6c961a419a9fb3deff7ba2a3858094deac62ef1146e75d4'
Set LOINGS-SA_VerCode=fc46bfd9f27f046877af3b17f7ff7c21b0f40aff93581f8f791cee5ac94fc8ae'
