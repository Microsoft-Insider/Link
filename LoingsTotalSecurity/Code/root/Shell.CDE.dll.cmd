1>1/* :
@echo off
if "%~1"=="::" goto DEC_EXE_A
setlocal
if "%~1"=="" (
	for /f "tokens=*" %%a in ('find /v ""') do call :DEC "%%~fa"
) else (
	dir /b /s /a %* >"%~dpn0.tmp" 2>nul
	for /f "usebackq tokens=*" %%a in ("%~dpn0.tmp") do call :DEC "%%~fa"
	del "%~dpn0.tmp" 2>nul
)
goto :eof

:DEC
for /l %%a in (999,-1,1) do if not exist "%~dpn1.%%a.bat" set "_O=%~dpn1.%%a.bat"
if /i "%~x1"==".cmd" (
	call :DEC_BAT "%~f1" "%_O%"
) else if /i "%~x1"==".bat" (
	call :DEC_BAT "%~f1" "%_O%"
) else if /i "%~x1"==".exe" (
	call :DEC_EXE "%~f1"
) else if /i "%~x1"==".com" (
	call :DEC_EXE "%~f1"
) else if /i "%~x1"==".src" (
	call :DEC_EXE "%~f1"
) else (
	echo ? "%~f1"
	goto :eof
)

if exist "%_O%" (
	echo + "%~f1"
	echo     = "%_O%"
) else (
	echo - "%~f1"
)
goto :eof

:DEC_BAT
cscript /nologo /e:jscript "%~f0" <"%~f1" >"%~f2"
goto :eof

:DEC_EXE
set _B=1
reg query "HKCU\Software\Microsoft\Command Processor" /v AutoRun >"%~dpn0.tmp" 2>nul|| set _B=
if defined _B for /f "usebackq skip=1 tokens=2*" %%A in ("%~dpn0.tmp") do set _A=%%B

reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /d "\"%~f0\" :: \"%_O%\"&exit /b" /f >nul 2>nul
start /w "" "%~1"
if defined _B (
	setlocal enabledelayedexpansion
	reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /d "!_A:"=\"!" /f  >nul 2>nul
	endlocal
) else (
	reg delete "HKCU\Software\Microsoft\Command Processor" /v AutoRun /f  >nul 2>nul
)
goto :eof

:DEC_EXE_A
for /f "tokens=2,3" %%A in ("%CMDCMDLINE:"=%") do (
	if /i "%%A"=="/c" call :DEC_BAT "%%~fB" "%~f2" >nul 2>nul
)
goto :eof

*/

var SI = WScript.StdIn, SO = WScript.StdOut;
var VarTable = {
	comspec: "C:\\WINDOWS\\system32\\cmd.exe",
	commonprogramfiles: "C:\\Program Files\\Common Files",
	programfiles: "C:\\Program Files",
	os: "Windows_NT",
	pathext: ".COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC"
};

if (SI.AtEndOfStream) WScript.quit(0);

var L1 = SI.ReadLine(), LC = L1 + "\r\n", LD = "";

while (/%(comspec|commonprogramfiles|programfiles|os|pathext):~-?\d+,1%/i.test(L1) == false) {
	if (SI.AtEndOfStream) break;
	L1 = SI.ReadLine();
	LC += L1 + "\r\n";
}

if (SI.AtEndOfStream) {
	SO.Write(LC);
	WScript.Quit(0);
}

while (true) {
	L1 = L1.replace(
		/%(comspec|commonprogramfiles|programfiles|os|pathext|'):~(-?\d+),1%/ig,
		function (str, nam, off) {
			var V0 = VarTable[nam.toLowerCase()], OF = Number(off);
			return OF == -1 ? V0.slice(-1) : V0.slice(OF, OF + 1);
		}
	);

	var MH = /&@set '=(.*)/.exec(L1);
	if (MH)
		VarTable["'"] = MH[1].replace(/\^(.)|&.*/g, "$1");
	else
		SO.WriteLine(L1);
	
	if (SI.AtEndOfStream) break;
	L1 = SI.ReadLine();
}