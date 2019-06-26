@(
	Echo off
	Cd /d "%~dp0"
	SetLocal EnableDelayedExpansion
	Cls
	Echo.Loings Total Security
	Echo.
)

Echo. Debug in progress
Wmic process get CommandLine,Name | Findstr /i "Find Wmic Cacls" | Find "%~dp0" >"Temp\Runner.tmp"
For /f %%a in (Temp\Runner.tmp) do (
	For %%A in (Find,Findstr,Wmic,Cacls,Icacls) do (
		Find "%%A" "%%a">nul 2>nul&&(
			Taskkill /f /im %%A.exe >nul 2>nul
		)
	)
)

(
	Echo. Judging whether the process is running
	If exist Variable\Run.Info.bat Call "Variable\Run.Info.bat" &Set S=T
	If exist "Variable\Run.Info.2.bat" Call "Variable\Run.Info.2.bat" &Set S=T
	If exist "Variable\Run.Info.3.bat" Call "Variable\Run.Info.3.bat" &Set S=T
)
If "%S%"=="T" (
	Tasklist /fi "PID eq !LTS.Run.Process.Id!"|Find "!LTS.Run.Process.Id!"&&(
		Set "LTS.Run.Main=True"
	)
	If not "!LTS.Run.Process.Id.RP!"=="" (
		If exist "%~dp0Registry\SafetyCenter\RuntimeProtect\True.cmd" (
			Tasklist /fi "PID eq !LTS.Run.Process.Id.RP!"|Find "!LTS.Run.Process.Id.RP!"&&(
				Set "LTS.Run.RtPt=True"
			)
		)
	)
	If not "!LTS.Run.Process.Id.OS!"=="" (
		If exist "%~dp0Registry\SafetyCenter\SelfProtect\True.cmd" (
			Tasklist /fi "PID eq !LTS.Run.Process.Id.OS!"|Find "!LTS.Run.Process.Id.OS!"&&(
				Set "LTS.Run.SePt=True"
			)
		)
	)
) >nul 2>nul

Call SummonVar.dll.cmd
If not "%LTS.Run.Main%"=="True" (
	Echo. Creating master process
	Start "Loings Total Security %random%" "%Windir%\system32\cmd.exe" /d /c "%~dp0Main.cmd"
	Echo. Successfully. - !ErrorLevel!
) 2>nul
Echo. >"Temp\run.tmp"
If not "%LTS.Run.SePt%"=="True" (
	If exist "%~dp0Registry\SafetyCenter\SelfProtect\True.cmd" (
		Echo. Creating self protection process
		Start /low /min "Loings Total Security %random%" "%Windir%\system32\cmd.exe" /d /c "%~dp0OwnSafe.cmd"
		Echo. Successfully. - !ErrorLevel!
	)
) 2>nul
If not "%LTS.Run.RtPt%"=="True" (
	If exist "%~dp0Registry\SafetyCenter\RuntimeProtect\True.cmd" (
		Echo. Creating real-time protection process
		Start /low /min "Loings Total Security %random%" "%Windir%\system32\cmd.exe" /d /c "%~dp0RuntimeProtect.cmd"
		Echo. Successfully. - !ErrorLevel!
	)
) 2>nul

Echo.Exiting Runner
Exit

:Sign-LOINGS_4 
Set LOINGS-SA_Name=Loings Total Security'
Set LOINGS-SA_Info=LOINGS 全功能安全套装'
Set LOINGS-SA_Version=1.0'
Set LOINGS-SA_Safe=NORMAL'
Set LOINGS-SA_MinEnv=6.1'
Set LOINGS-SA_Writter=LOINGS_Corporation_O1'
Set LOINGS-SA_PublicKey=87959f0338d6017ea269a2d63b3a58d1'
Set LOINGS-SA_PrivateVer=19cb0b8a2d6fd78e7082f276b51396039caac51d673788c6f0dc363d6a15e0d7'
Set LOINGS-SA_VerCode=cd2085548798e745205622b6eab729cc30f87932b3644ac8e00d8cd81d9f02d3'
