@Echo off
Mode con cols=80 lines=21
Echo.Loading...
Color F3					%=设置颜色=%
Title LOINGS Digital Signature			%=设置标题=%
Setlocal Enabledelayedexpansion			%=开启变量延迟=%
Set TODAY=%date:~0,4%%date:~5,2%%date:~8,2%	%=获取日期=%
Set "Var.1=Sign-"
Set "Var.2=LOINGS"
Cd /d "%~dp0"

::API
If not "%~1"=="" Set "Code=%~1"&&Goto Ver
Goto M

Copyright (C) 2019 LOINGS Corporation all rights reserved.

:M
Cd /d "%~dp0"
Cls
Echo.
Echo. LOINGS 数字签名
Echo. ______________________________________________________________________________
Echo.
Echo. 输入文件路径
Echo.
Echo.
Echo.
Echo.  [drive:][path]filename
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
Set Code=
Set /p Code= ^>
Call Exp_dll.cmd %Code%
Set "Code=%P_Temp%"
If "%Code%"=="" Goto M
Set P_Temp=
Goto Ver

:Ver
:FileVer
Cls
Echo.
Echo. LOINGS 数字签名
Echo. ______________________________________________________________________________
Echo.
Echo.
Echo.
Echo.
Echo.     请稍等...
Echo.
Echo.
Echo.
For %%a in (Name,Info,Version,Safe,MinEnv,Wirter,Writter,SHA256,VerCode,PublicKey,PrivateVer) do (
	Set "LOINGS-SA_%%a="
)
For %%a in (PN,LSW,RegVersion,RECE,Hash,EFA) do (
	Set "%%a="
)
Set Hash.Code=
Set Hash.Fail=
If not exist "%Code%" Goto :E0
Findstr "%Var.1%%Var.2%" "%Code%" >nul 2>nul || Goto :E1
Findstr "^Set.LOINGS-SA_" "%Code%"|Findstr /v "&" |Findstr /v "|" |Findstr /v "Set./p" >SetTemp.cmd
Call SetTemp.cmd
Del /f /q SetTemp.cmd >nul 2>nul
Findstr "%Var.1%%Var.2%_4" "%Code%" >nul 2>nul || Goto :Old
Set Ve=4.0
For %%a in (Name,Info,Version,Safe,MinEnv,Wirter,Writter,SHA256,VerCode,PublicKey,PrivateVer) do (
	If Defined LOINGS-SA_%%a If "!LOINGS-SA_%%a:~-1!"=="'" Set "LOINGS-SA_%%a=!LOINGS-SA_%%a:~0,-1!"
)
If not Defined LOINGS-SA_PrivateVer Goto :E3
Goto :Skip
:Old
Findstr "^LOINGS-SA_" "%Code%" >nul 2>nul &&Set Ve=1.0&&Goto :Do1.0
If not "%LOINGS-SA_Name:~-1%"=="'" (
	Set Ve=2.0
) else (
	Set Ve=3.0
)
For %%a in (Name,Info,Version,Safe,MinEnv,Wirter,Writter,SHA256,VerCode) do (
	If Defined LOINGS-SA_%%a If "!LOINGS-SA_%%a:~-1!"=="'" Set "LOINGS-SA_%%a=!LOINGS-SA_%%a:~0,-1!"
)
:Skip
(
Set PN=
Set EFA=
Set RegVersion=
Set RECE=未知
Set LCMD=未知
Set LSW=未知的发布者
Set Hash=未发现文件指纹
)
(
Set "PN=%LOINGS-SA_Name%"
Set "EFA=%LOINGS-SA_Info%"
Set "LSW=%LOINGS-SA_Writter%"
Set "RegVersion=%LOINGS-SA_Version%"
)
(
If "%PN%"=="" Set PN=未知应用程序
If "%EFA%"=="" Set EFA=无。
If "%RegVersion%"=="" 		Set RegVersion=未知
If "%LOINGS-SA_Writter%"=="" Set "LSW=%LOINGS-SA_Wirter%"
If "%LOINGS-SA_Safe%"=="TOP" 	Set RECE=最高等级
If "%LOINGS-SA_Safe%"=="HIGH" 	Set RECE=高等级
If "%LOINGS-SA_Safe%"=="NORMAL" Set RECE=标准等级
If "%LOINGS-SA_Safe%"=="LOW" 	Set RECE=次等级
If "%LOINGS-SA_Safe%"=="VOL" 	Set RECE=低等级
If "%LOINGS-SA_MinEnv%"=="6.1" 	Set LCMD=Windows7
If "%LOINGS-SA_MinEnv%"=="6.3" 	Set LCMD=Windows8.1
If "%LOINGS-SA_MinEnv%"=="10.0" Set LCMD=Windows10
)
If not "%PN%"=="未知应用程序" If "%LOINGS-SA_Wirter%"=="LOINGS_Corporation_O1" Set "LSW=LOINGS Corporation"
If not "%PN%"=="未知应用程序" If "%LOINGS-SA_Writter%"=="LOINGS_Corporation_O1" Set "LSW=LOINGS Corporation"
:Back_0
If "%Ve%"=="4.0" If not "%LOINGS-SA_VerCode%"=="" Goto :VerHash.SHA256
If not "%LOINGS-SA_SHA256%"=="" Goto :VerHash.SHA256_Old
Goto :SignOut

:VerHash.SHA256
Findstr /v "^Set.LOINGS-SA_VerCode" "%Code%" >HashSign.Ver.tmp
Echo."%LOINGS-SA_PublicKey%">PublicKey.key
Copy /b "HashSign.Ver.tmp" + PublicKey.key "NewFile.tmp" >nul 2>nul
Certutil -hashfile "%~dp0NewFile.tmp" SHA256|Findstr /v "哈希 hashfile" >HashSign.Code.tmp
For /F "usebackq delims=" %%i in (HashSign.Code.tmp) do Set "Hash.Code=%%i"

Del /f /q "HashSign.Ver.tmp" "HashSign.Code.tmp" "PublicKey.key" "NewFile.tmp" >nul 2>nul

Set BNum=2
If "%Hash.Code:~2,1%"==" " Goto :GetCode
:Back_2
If "%LOINGS-SA_VerCode%"=="%Hash.Code%" (
	Set "Hash=SHA256+PublicKey （有效）"
	Set "HashFail="
) else (
	Set "Hash=SHA256+PublicKey （文件被更改）"
	Set "HashFail=True"
)
If "%HashFail%"=="True" Goto :Hash.Fail
Goto :SignOut

:GetCode
(
Set "Hash.Code.part1=%Hash.Code:~0,2%%Hash.Code:~3,2%%Hash.Code:~6,2%%Hash.Code:~9,2%%Hash.Code:~12,2%%Hash.Code:~15,2%%Hash.Code:~18,2%"
Set "Hash.Code.part2=%Hash.Code:~21,2%%Hash.Code:~24,2%%Hash.Code:~27,2%%Hash.Code:~30,2%%Hash.Code:~33,2%%Hash.Code:~36,2%%Hash.Code:~39,2%"
Set "Hash.Code.part3=%Hash.Code:~42,2%%Hash.Code:~45,2%%Hash.Code:~48,2%%Hash.Code:~51,2%%Hash.Code:~54,2%%Hash.Code:~57,2%%Hash.Code:~60,2%"
Set "Hash.Code.part4=%Hash.Code:~63,2%%Hash.Code:~66,2%%Hash.Code:~69,2%%Hash.Code:~72,2%%Hash.Code:~75,2%%Hash.Code:~78,2%%Hash.Code:~81,2%"
Set "Hash.Code.part5=%Hash.Code:~84,2%%Hash.Code:~87,2%%Hash.Code:~90,2%%Hash.Code:~93,2%"
)
Set "Hash.Code=%Hash.Code.part1%%Hash.Code.part2%%Hash.Code.part3%%Hash.Code.part4%%Hash.Code.part5%"
Goto :Back_%BNum%

:VerHash.SHA256_Old
Findstr /v "%Var.1%%Var.2%" "%Code%"|Findstr /v "^Set.LOINGS-SA_" >HashSign.Ver.tmp
Certutil -hashfile "HashSign.Ver.tmp" SHA256|Findstr /v "哈希 hashfile" >HashSign.Code.tmp
For /F "usebackq delims=" %%i in (HashSign.Code.tmp) do Set "Hash.Code=%%i"
Del /f /q "HashSign.Ver.tmp" "HashSign.Code.tmp" >nul 2>nul
If not Defined LOINGS-SA_SHA256 Goto :E-2
Set BNum=10
If "%Hash.Code:~2,1%"==" " Goto :GetCode
:Back_10
Set "HashFail="
If not Defined Hash.Code Goto :E-2
Set Hash.Code2=%Hash.Code%
If Defined LOINGS-SA_VerCode Goto Adv.Sign
If "%LOINGS-SA_SHA256%"=="%Hash.Code2%" (
	Set "Hash=SHA256 （有效）"
) else (
	Set "Hash=SHA256 （文件被更改）"
	Set "HashFail=True"
)
If "%HashFail%"=="True" Goto Hash.Fail
Goto :SignOut_Old
:Adv.Sign
Findstr /v "^Set.LOINGS-SA_VerCode" "%Code%" >HashSign.Ver.tmp
Certutil -hashfile "%~dp0HashSign.Ver.tmp" SHA256|Findstr /v "哈希 hashfile" >HashSign.Code.tmp
For /F "usebackq delims=" %%i in (HashSign.Code.tmp) do Set "Hash.Code=%%i"
Del /f /q HashSign.Ver.tmp >nul 2>nul
Del /f /q HashSign.Code.tmp >nul 2>nul
Set BNum=12
If "%Hash.Code:~2,1%"==" " Goto :GetCode
:Back_12
If "%LOINGS-SA_VerCode%"=="%Hash.Code%" (
	Set "Hash=SHA256 *2 （有效）"
) else (
	Set "Hash=SHA256 *2 （文件被更改）"
	Set "HashFail=True"
)
If "%HashFail%"=="True" Goto :Hash.Fail
Goto :SignOut_Old

:Do1.0
If "%~2"=="/FeedBack" Goto :Eof
Cls
Echo.
Echo. LOINGS 数字签名
Echo. ______________________________________________________________________________
Echo.
Echo. 信息
Echo.
Echo.
Echo.   程序名称：%PN%(%Code%)
Echo.
Echo.      该低版本签名已不受支持。
Echo.
Echo.      注册类型：LOINGS Sign %Ve%
Echo.
Echo.
Echo.      
Echo.
Echo.
Echo.
Echo.
Pause >nul
If not "%~1"=="" Exit
Goto M

:Hash.Fail
If "%~2"=="/FeedBack" Goto :Eof
Cls
Echo.
Echo. LOINGS 数字签名
Echo. ______________________________________________________________________________
Echo.
Echo. 信息
Echo.
Echo.
Echo.   程序名称：%PN%(%Code%)
Echo.
Echo.    文件签名无效。
Echo.
Echo.      注册类型：LOINGS Sign %Ve%
Echo.      文件效验：%Hash%
Echo.
Echo.      签名值：%LOINGS-SA_VerCode%
Echo.      实际值：%Hash.Code%
Echo.
Echo.
Echo.
Pause >nul
If not "%~1"=="" Exit
Goto M

:SignOut
If "%~2"=="/FeedBack" Goto :Eof
Cls
Echo.
Echo. LOINGS 数字签名
Echo. ______________________________________________________________________________
Echo.
Echo. 信息
Echo.
Echo.   程序名称：%PN%(%Code%)
Echo.
Echo.   程序作者：%LSW%(PK:%LOINGS-SA_PublicKey:~0,10%...)
Echo.
Echo.      程序版本：%RegVersion%
Echo.      最低要求：%LCMD%
Echo.      权限等级：%RECE%
Echo.      注册类型：LOINGS Sign %Ve%
Echo.      文件效验：%Hash%
Echo.
Echo.      详细信息：%EFA%
Pause >nul
If not "%~1"=="" Exit
Goto M

:SignOut_Old
If "%~2"=="/FeedBack" Goto :Eof
Cls
Echo.
Echo. LOINGS 数字签名
Echo. ______________________________________________________________________________
Echo.
Echo. 信息 - 该注册方式存在被更改的可能性
Echo.
Echo.   程序名称：%PN%(%Code%)
Echo.
Echo.   程序作者：%LSW%
Echo.
Echo.      程序版本：%RegVersion%
Echo.      最低要求：%LCMD%
Echo.      权限等级：%RECE%
Echo.      注册类型：LOINGS Sign %Ve%
Echo.      文件效验：%Hash%
Echo.
Echo.      详细信息：%EFA%
Pause >nul
If not "%~1"=="" Exit
Goto M

:E0
Cls
Echo.
Echo. LOINGS 数字签名
Echo. ______________________________________________________________________________
Echo.
Echo. 信息
Echo.
Echo.
Echo.
Echo.  找不到文件。
Echo.
Echo.
Echo.
Echo.
Echo.
Pause
If not "%~1"=="" Exit
Goto M

:E1
Cls
Echo.
Echo. LOINGS 数字签名
Echo. ______________________________________________________________________________
Echo.
Echo. 信息
Echo.
Echo.
Echo.
Echo.  该文件没有被签名。
Echo.
Echo.
Echo.
Echo.
Echo.
Timeout /t 3 >nul 2>nul
If not "%~1"=="" Exit
Goto M

:E2
Cls
Echo.
Echo. LOINGS 数字签名
Echo. ______________________________________________________________________________
Echo.
Echo. 信息
Echo.
Echo.
Echo.
Echo.  出现了一个错误，程序无法继续。
Echo.
Echo.    Error:变量为空。
Echo.
Echo.
Echo.
Timeout /t 3 >nul 2>nul
If not "%~1"=="" Exit
Goto M

:E3
Cls
Echo.
Echo. LOINGS 文件数字签名向导
Echo. ______________________________________________________________________________
Echo.
Echo. 信息
Echo.
Echo.
Echo.
Echo.
Echo.     该文件签名未包含私钥对比值，该文件非官方工具签名，
Echo.     签名者试图有意抹去私钥值以通过验证，
Echo.     签名已失效，不具有其签名意义。
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Timeout /t 3 >nul 2>nul
If not "%~1"=="" Exit
Goto M

:Eof
:Sign-LOINGS_4 
Set LOINGS-SA_Name=LOINGS 数字签名工具'
Set LOINGS-SA_Info=帮助发布者对开发的程序、编写的文件进行LOINGS数字签名。'
Set LOINGS-SA_Version=4.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=406318f743176fdec8edf93923fae7ed9c6ed2d8255459507c00e04bda8087ba'
Set LOINGS-SA_VerCode=64c859bf21ad122bb6721a828eeb6c1f87288d5e17e2f9fddf47a94fe421a307'
