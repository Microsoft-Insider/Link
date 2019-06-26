@Echo off
If Not "!OS!"=="%OS%" CMD /V:ON /C "%~f0" %*&Goto :Eof	%=变量延迟=%
(
Del Act.html Temp.html 2>nul
!DLR! Act.html "!SLO!"
If Not Exist Act.html Goto Err-1
)&(
Find /I " title='%~1" <Act.html >temp.html||Goto Err-2	%=获得关键行=%
Set /p Word=<temp.html				%=将关键行读取到变量=%
Del Act.html temp.html 2>nul
)
::						截取链接前的字符
For /l %%P In (0,1,8191) Do If /i "!Word:~%%P,7!"==" href='" Set /a P=%%P+7
Set Word=!Word:~%P%!
::						截取链接后的字符
For /l %%P In (8191,-1,0) Do If /i "!Word:~%%P,2!"=="'>" Set P=%%P
Set Word=!Word:~,%P%!
(
Del "%~2" 2>nul
!DLR! "%~2" "!Word!"				%=下载=%
If Not Exist "%~2" Goto Err-3
)
Set DLError=0
Goto :Eof

:Err-1
Set DLError=1
Goto :Eof
:Err-2
Set DLError=2
Goto :Eof
:Err-3
Set DLError=3
Goto :Eof
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS 全功能安全套装'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=2900a7d127f08a95ae015c6c4efac2519fec17bdf637fb388fc7993a15272cfc'
Set LOINGS-SA_VerCode=c2dae85b71a2e302ca333aa76515a5c42a71412db7f1a8d6bfedf102e5847215'
