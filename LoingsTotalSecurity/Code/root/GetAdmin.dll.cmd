@(
	Setlocal enabledelayedexpansion
	Set params=%*
	If defined params (
		Set "params=!params:"=""!"
		Set "params=!params:?=&!"
	)
	Net session >nul 2>nul || (
		Mshta vbscript:CreateObject^("Shell.Application"^).ShellExecute^("cmd.exe","/c call !params!","","runas",1^)^(window.close^)
		Exit
	)
)
@Endlocal & Goto :Eof
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS 全功能安全套装'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=261dec232c67269409f33f7fcae48e8a08eddfca67b0ede685722ae7e4b9aec0'
Set LOINGS-SA_VerCode=2b2d495e7a6704a58595fce32238e9024d0dbd2dba14f5e38fafee5bd11ab672'
