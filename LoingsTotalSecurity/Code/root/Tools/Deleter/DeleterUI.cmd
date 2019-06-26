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
Echo. 主页
Echo.
Echo. __________________________________________________________
Echo.
Echo.      1.  删除指定文件（夹）
Echo.
Echo.      2.  设置
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
Choice /c 12 /n /m 选择：
If Errorlevel 2 Goto Config
If Errorlevel 1 Goto Delete
Goto Home

:Delete
Cls
Echo. LOINGS Deleter
Echo.
Echo.
Echo. 输入路径
Echo.
Echo. __________________________________________________________
Echo.
Echo. 请输入路径，路径格式为：
Echo.
Echo. Drive:\Paths\Names
Echo.
Echo. 您也可以尝试将文件拖拽到本窗口中。
Echo.
Echo.        1. 程序支持通配符；
Echo.        2. 程序将自动识别文件或文件夹；
Echo.        3. 在不知其作用时不要删除系统文件；
Echo.        4. 当启用高级清除技术时：
Echo.           (1) 自动结束妨碍删除文件的进程；
Echo.           (2) 将会在删除前执行权限获取；
Echo.           (3) 将会采用多种方式清除文件；
Echo.           (4) 程序将会忽略路径是否正确。
Echo.
Echo.不输入则返回
Set string=
Set /p string=路径：
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
Echo. 设置
Echo.
Echo. __________________________________________________________
Echo.
Echo.      1.  显示调整
Echo.
Echo.      2.  功能开关
Echo.
Echo.      3.  自动执行
%Echo5%
%Echo5%
%Echo5%
Echo. B. 反回
Choice /c 123B /n /m 选择：
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
Echo. 设置^> 显示调整
Echo.
Echo. __________________________________________________________
Echo.
Echo.      1.  文件删除反馈
Echo.
Echo.      2.  权限获取反馈
Echo.
Echo.      3.  删除前提示确认
%Echo5%
%Echo5%
%Echo5%
Echo. B. 反回
Choice /c 123B /n /m 选择：
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
Echo. 设置^> 显示调整^> 文件删除反馈
Echo.
Echo. __________________________________________________________
Echo.
Echo.      Y.  启用（默认）
Echo.
Echo.      N.  禁用
Echo.
Echo.
%Echo5%
%Echo5%
%Echo5%
Echo. B. 反回
Choice /c YNB /n /m 选择：
If Errorlevel 3 Goto S-1
If Errorlevel 2 Set "DSD=>NUL"&&Goto SetData
If Errorlevel 1 Set "DSD="&&Goto SetData
Goto Config
:S-1-2
Cls
Echo. LOINGS Deleter
Echo.
Echo.
Echo. 设置^> 显示调整^> 权限获取反馈
Echo.
Echo. __________________________________________________________
Echo.
Echo.      Y.  启用（默认）
Echo.
Echo.      N.  禁用
Echo.
Echo.
%Echo5%
%Echo5%
%Echo5%
Echo. B. 反回
Choice /c YNB /n /m 选择：
If Errorlevel 3 Goto S-1
If Errorlevel 2 Set "GSD=>NUL"&&Goto SetData
If Errorlevel 1 Set "GSD="&&Goto SetData
Goto Config
:S-1-3
Cls
Echo. LOINGS Deleter
Echo.
Echo.
Echo. 设置^> 显示调整^> 删除前提示确认
Echo.
Echo. __________________________________________________________
Echo.
Echo.      Y.  启用
Echo.
Echo.      N.  禁用（默认）
Echo.
Echo.
%Echo5%
%Echo5%
%Echo5%
Echo. B. 反回
Choice /c YNB /n /m 选择：
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
Echo. 设置^> 功能开关
Echo.
Echo. __________________________________________________________
Echo.
Echo. 高级清除技术
Echo.
Echo.      Y.  启用（默认）
Echo.
Echo.      N.  禁用
Echo.
Echo.     启用高级清除技术以强制删除文件。
Echo.
Echo.
Echo.
%Echo5%
%Echo5%
Echo. B. 反回
Choice /c YNB /n /m 选择：
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
Echo. 设置^> 自动执行
Echo.
Echo. __________________________________________________________
Echo.
Echo. 设置自动选择的时间
Echo.
Echo.   默认自动选择默认选项的时间是3秒；
Echo.
Echo.   您现在可以手动输入等待的时间，单位为秒；
Echo.
Echo.   当设为0时，程序将自动执行。
Echo.
Echo.   当前值：%T%
Echo.
%Echo5%
%Echo5%
Echo. B. 反回
Set /p TT=输入：
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