@Echo off
Cd /d "%~dp0"

Set >Variable\Normal.cmd
Set "Var.Temp=%~dp0"
(
Echo.Set "Loings.FileName.Data=%~dp0Data"
Echo.Set "Loings.FileName.Dlls=%~dp0DynamicLinkLibraries"
Echo.Set "Loings.FileName.Modules=%~dp0Modules"
Echo.Set "Loings.FileName.Program=%Var.Temp:~0,-1%"
Echo.Set "Loings.FileName.Registry=%~dp0Registry"
Echo.Set "Loings.FileName.Temp=%~dp0Temp"
Echo.Set "Loings.FileName.Variable=%~dp0Variable"
) >Variable\BasicEnvironment.bat
(
Echo.Set "Link.Cmd.Main=%~dp0Main.cmd"
Echo.Set "Link.Cmd.Perm=%~dp0Permissions.cmd"
) >Variable\Links.cmd
Goto :Eof
:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS 全功能安全套装'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=85208a221705baa6bc3d50bc0e11ca1806353a44c0b974c524d8221a8cb1b847'
Set LOINGS-SA_VerCode=20f7c98723b502d250e10d1b8ebb997441735b4f4cd3e121c32ae1598623e926'
