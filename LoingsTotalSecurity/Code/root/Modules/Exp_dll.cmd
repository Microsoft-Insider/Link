Set "paths=%~dp1"
Set "P1=%~1"&Set "P2=%~2"&Set "P3=%~3"&Set "P4=%~4"&Set "P5=%~5"&Set "P6=%~6"
Set "P_Temp=%P1% %P2% %P3% %P4% %P5% %P6%"
If "%P6%"=="" Set "P_Temp=%P1% %P2% %P3% %P4% %P5%"
If "%P5%"=="" Set "P_Temp=%P1% %P2% %P3% %P4%"
If "%P4%"=="" Set "P_Temp=%P1% %P2% %P3%"
If "%P3%"=="" Set "P_Temp=%P1% %P2%"
If "%P2%"=="" Set "P_Temp=%P1%"
If "%P1%"=="" Set "P_Temp="&& Goto Eof

:Eof
Set P1=&Set P2=&Set P3=&Set P4=&Set P5=
:Sign-LOINGS 
Set LOINGS-SA_Name=LOINGS Explorer Open Shell'
Set LOINGS-SA_Info=用于对用户输入的文本进行过滤筛选，确保其一致性。'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_SHA256=75c3a98c6bef3698711e387740070633e651cf0cc40b6bc130e621989273c313'
Set LOINGS-SA_VerCode=e3dcf9bfa661665b401932be21645b46d2245b9f221450f25510211a16cb7fbb'
