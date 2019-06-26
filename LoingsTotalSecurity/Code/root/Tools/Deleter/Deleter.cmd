@Echo off
@Chcp 437 >Nul
@Title LOINGS Deleter
Cls
Echo.LOINGS Deleter
Echo.(C) 2019 LOINGS Corporation
Set GSD=
Set DSD=
Set TES=True
Set P=
Set T=3
If exist "Config.info.cmd" Call Config.info.cmd
If "%~1"=="" Goto Error-1
If "%~1"=="%~0" Goto Error-2
If "%~1"=="%~nx0" Goto Error-2
If exist "%~1" Goto N >Nul 2>nul
Echo.
Choice /m "The file could not be found. Do you want to continue?(Continue in %T% second)" /c YN /t %T% /d Y
If "%ERRORLEVEL%"=="1" Goto N
If "%ERRORLEVEL%"=="2" Goto Ex

:N
Echo.
If "%TES%"=="False" Echo.Delete File(s):%~1
Echo.Please make sure the file is correct.
Choice /m "Press any key to close, or press A to continue.(Continue in %T% second)" /n /c abcdefghijklmnopqrstuvwxyz1234567890 /t %T% /d A
If "%ERRORLEVEL%"=="1" Goto D
Goto Ex

:D
If "%TES%"=="False" Goto DF1
Echo.Getting permission...
Echo. Acquiring ownership
Takeown /r /d y /f %1 %GSD% 2>Nul
Echo. Getting full control
Echo.Y|Cacls %1 /t /c /g %Username%:F %GSD% 2>Nul
Echo. Forcibly ending process
Taskkill /f /im %~nx1 >nul 2>nul

:DF1
Echo.
Echo.Deleting Files...
Echo. The first stage
Del /F /Q %P% "%~1" %DSD% 2>Nul
If "%TES%"=="False" Goto DF2
Echo. The second stage
Del /F /S /Q %P% "%~1\*.*" %DSD% 2>Nul
Del /F /A /Q %P% "\\?\%~1" %DSD% 2>Nul
Echo. The third stage
Del /F /Q /A:S %P% "\\?\%~1" %DSD% 2>Nul
Del /F /Q /A:L %P% "\\?\%~1" %DSD% 2>Nul
Del /F /Q /A:R %P% "\\?\%~1" %DSD% 2>Nul
Del /F /Q /A:H %P% "\\?\%~1" %DSD% 2>Nul
Del /F /Q /A:I %P% "\\?\%~1" %DSD% 2>Nul
Del /F /Q /A:A %P% "\\?\%~1" %DSD% 2>Nul

:DF2
Echo.Deleting Folders...
Echo. The first stage
Del /S /F /Q %P% "%~1\*.*" %DSD% 2>Nul
Rd /S /Q %1 2>Nul
If "%TES%"=="False" Goto F
Echo. The second stage
Set "Data=%~1"
Rd /S /Q "%Data:~0,2%\\%Data:~2,500%\\" %DSD% 2>Nul
Echo. The third stage
Rd /S /Q "\\?\%~1" %DSD% 2>Nul
Rd /S /Q "\\?\%~1\\" %DSD% 2>Nul

:F
If exist %1 Goto E 2>Nul
If exist %1\ Goto E 2>Nul
If exist %1\\ Goto E 2>Nul
Echo.Successfully completed.
Echo.
Choice /m "Press any key to Close...(Close in %T% second)" /n /c abcdefghijklmnopqrstuvwxyz1234567890 /t %T% /d 0
Goto Eof

:E
Echo.Failed to delete.
Echo.
Choice /m "Press any key to Close...(Close in %T% second)" /n /c abcdefghijklmnopqrstuvwxyz1234567890 /t %T% /d 0
Goto Eof

:Ex
Echo.No tasks performed.
Echo.
Choice /m "Press any key to Close...(Close in %T% second)" /n /c abcdefghijklmnopqrstuvwxyz1234567890 /t %T% /d 0
Goto Eof

:Error-1
Echo.
If "%~2"=="/Run" Goto Eof
Set /p Paths= Please give the path^>
Start "" %0 %Paths%
Goto Eof

:Error-2
Echo.
Echo.The operation cannot be performed on itself.
Echo.
Choice /m "Press any key to Close...(Close in %T% second)" /n /c abcdefghijklmnopqrstuvwxyz1234567890 /t %T% /d 0
Goto Eof

:Eof
If not "%~2"=="/Run" Exit