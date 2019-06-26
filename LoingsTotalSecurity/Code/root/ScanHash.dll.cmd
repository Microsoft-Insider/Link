Certutil -hashfile "%~1" SHA256 | Findstr /v ": hashfile">Temp\temp.hash
(
Set "B=False"
Set /p Hash.Code=<Temp\temp.hash
) >nul 2>nul
If "%Hash.Code:~2,1%"==" " Set "Hash.Code=%Hash.Code: =%"
Find "%Hash.Code%" "Library\Lib.SHA256_1.vsh" >nul 2>nul&&(
	Set "B=True"
)
Goto :Eof
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS 全功能安全套装'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=d8e9f34009ce8225c9bd3d238fb397c61bf394df175647f36fc7acd566a2edda'
Set LOINGS-SA_VerCode=4927f550629209f7e4412800f4a1b327b1823925cc336fa1391953b4c4ac09cb'
