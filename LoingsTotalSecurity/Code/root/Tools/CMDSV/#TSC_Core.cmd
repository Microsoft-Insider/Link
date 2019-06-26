@Echo off&@Goto P
:P
(
Set "S1=%1"
Set "S2=%2"
Set "S3=%3"
Set "S4=%4"
Set "S5=%5"
Set "S6=%6"
Set "S7=%7"
Set "S8=%8"
Set "S9=%9"
Set EW=
Set Error_5932=
)
For /l %%a in (1,1,9) do (
	If /i "!S%%a:~0,1!"=="@" Set EW=0
)
If "%EW%"=="0" Goto E-0

If /i "%S1%"=="CMD" Set EW=1
If /i "%S1:~1,3%"=="CMD" Set EW=1
If "%EW%"=="1" Goto E-1

If /i "%S1%"=="COMMAND" Set EW=2
If /i "%S1:~1,7%"=="COMMAND" Set EW=2
If "%EW%"=="2" Goto E-2

If /i "%~d1"=="%SystemDrive%" Set EW=3
If /i "%~d2"=="%SystemDrive%" Set EW=3
If /i "%~d3"=="%SystemDrive%" Set EW=3

For /l %%a in (1,1,9) do (
	If /i "!S%%a!"=="GOTO" Set EW=4
	If /i "!S%%a!"=="DEL" Set EW=5
	If /i "!S%%a!"=="CALL" Set EW=6
	If /i "!S%%a!"=="START" Set EW=7
	If /i "!S%%a!"=="SET" Set EW=9
	If /i "!S%%a!"=="TSKILL" Set EW=10
	If /i "!S%%a!"=="TASKKILL" Set EW=10
	If /i "!S%%a!"=="TASKLIST" Set EW=11
)

For /l %%a in (3,1,11) do (
	If "%EW%"=="%%a" Goto E-%%a
)

For /l %%a in (0,1,100) do (
	If /i "!CMD_SET:~%%a,1!"=="*" Set EW=8
)
If "%EW%"=="8" Goto E-8

If /i "%S1%"=="SET" If /i "%S2%"=="/P" Set "BL=%S3:%"&&Set EW=9-1
If "%EW%"=="9-1" Goto E-9-1
If "%EW%"=="9" Goto E-9

If /i "%S1%"=="IF" If /i "%S2%"=="not" If /i "%S3%"=="exist" Set EW=L1
If /i "%S1%"=="IF" If /i "%S2%"=="exist" Set EW=L1

If "%EW%"=="" Goto Eof
Set Error_5932=NoRun
Goto E-%EW%


:E-0
Echo.指令中含有“@”；
Echo.这会绕过检查，请去掉后重试。
Goto Stop
:E-1
Echo.禁止使用该指令；
Echo.该指令可能会对该电脑造成危害。
Goto Stop
:E-2
Echo.禁止使用该指令；
Echo.该指令可能会对该电脑造成危害。
Goto Stop
:E-3
Echo.禁止使用该指令；
Echo.该指令涉及系统盘，可能会对该电脑造成危害。
Goto Stop
:E-4
Echo.“GOTO”指令已被禁用。
Goto Stop
:E-5
Echo.将会删除文件；
Echo.如果您不确定该文件是否可删除，请阻止。
Goto End
:E-6
Echo.将会启动外部程序；
Echo.如果您不认识该程序，请阻止。
Goto End
:E-7
Echo.将会打开外部程序或网站；
Echo.如果您不认识该程序或网站，请阻止。
Goto End
:E-8
Echo.程序正在使用通配符“*”；
Echo.如果您不确定该命令的作用，请阻止。
Goto End
:E-9-1
Echo.将会更改的环境变量为“%S3%”；
Echo.如果您不确定该变量是否可更改，请直接“Enter”。
Goto Eof
:E-9
Echo.将会更改环境变量；
Echo.如果您不确定该变量是否可更改，请阻止。
Goto End
:E-10
Echo.将会结束进程；
Echo.如果您不确定结束的进程，请阻止。
Goto End
:E-11
Echo.“TASKLIST”指令已被禁用。
Goto Stop

:E-L1
Echo.将会探测外部文件；
Echo.如果您不确定该命令的后续作用，请阻止。
Goto End

:Stop
Set Error_5932=Stop
Goto Eof
:End
Set Error_5932=NoRun
Goto Eof
:Eof
Set T1=&Set T2=&Set T3=&Set T4=&Set T5=
Set T6=&Set T7=&Set T8=&Set T9=
Set S1=&Set S2=&Set S3=&Set S4=&Set S5=
Set S6=&Set S7=&Set S8=&Set S9=