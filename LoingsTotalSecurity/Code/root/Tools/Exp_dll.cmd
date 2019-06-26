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
:Sign-LOINGS_4 
Set LOINGS-SA_Name=LOINGS Explorer Open Shell'
Set LOINGS-SA_Info=用于对用户输入的文本进行过滤筛选，确保其一致性。'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=8f6ea1e2499c6ebd7a0c4d58d6c8d7d48b2afedf183e95942d7e0e5d8e4eb75c'
Set LOINGS-SA_VerCode=2d41ceaaf0b9e4b91a897f4b75b1372b19cd38e0f03fd3d6d889105a0a9bd2c0'
