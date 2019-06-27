@Echo off
If Not "!OS!"=="%OS%" CMD /V:ON /C "%~f0" %*&Goto :Eof	%=╠Да©ясЁы=%
Cd /d %~dp0
(
Bitsadmin /transfer !random! /download /priority foreground "https://raw.githubusercontent.com/Microsoft-Insider/Link/master/LoingsTotalSecurity/%~1/%~2" "%~f3"
If Not Exist "%~2" Goto Err-3
Set DLError=0
Goto :Eof
)

:Err-1
Set DLError=1
Goto :Eof
:Err-2
Set DLError=2
Goto :Eof
:Err-3
Set DLError=3
Goto :Eof
