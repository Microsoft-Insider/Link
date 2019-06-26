@Echo off
Set "S1=%1"
Set "S2=%2"
Set "S3=%3"
Set "S4=%4"
Set "S5=%5"
Set "S6=%6"
Set "S7=%7"
Set "S8=%8"
If /i "%S1%"=="Set" Goto NoS
If /i "%S1%"=="If" Goto NoS
If /i "%S1%"=="For" Goto NoS
%S1% %S2% %S3% %S4% %S5% %S6% %S7% %S8% %S9%
Goto Eof

:NoS
%CMD_SET%

:Eof
