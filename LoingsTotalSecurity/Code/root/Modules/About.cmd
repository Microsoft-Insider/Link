@(
	Echo off
	Mode con cols=63 lines=32
	Cd /d "%~dp0"
	Color F3
	Title 关于  Loings Total Security 2019
	Call LibVer.cmd
	Call ProVer.cmd
)

(
Cls
Echo.                                                        TM
Echo.      ▄      ▄▄▄▄  ▄  ▄▄▄▄  ▄▄▄▄  ▄▄▄▄
Echo.      █      █    █  █  █    █  █        █
Echo.      █      █    █  █  █    █  █  ▄▄  █▄▄▄
Echo.      █      █    █  █  █    █  █    █        █
Echo.      █▄▄  █▄▄█  █  █    █  █▄▄█  ▄▄▄█
Echo.
Echo. _____________________________________________________________
Echo.
Echo.
Echo.   产品信息：
Echo.      Loings Total Security 2019
Echo.
Echo.            创建号：%LocalVersion%
Echo.      上次产品更新：%LastUpProductTime%
Echo.
Echo.   反恶意软件引擎属性：
Echo.
Echo.          引擎版本：哈希算法引擎V%VEH%  行为辨别引擎V%VEB%
Echo.      上次引擎更新：%LastUpEngineTime%
Echo.        病毒特征库：%LocalVirusLibNum%
Echo.        哈希指纹库：%LocalHashLibNum%
Echo.
Echo.   主动防御技术：AutoRun + WmicGetPath + HashLib
Echo.   被动防御技术：Real-time + WmicGetPath + BehavioralLib
Echo.   文件扫描技术：HashCompare + BehavioralAnalysis + Exclude
Echo.
Echo.    反馈群：680477009 反馈邮箱：SystemOfficial@outlook.com
Echo.         ^(C^) %date:~0,4% LOINGS Corporation。 保留所有权利。
Echo.            ^(C^) %date:~0,4% BASIC United。 保留所有权利。
:R
Pause >nul
Goto :R
)

:Error-0
Echo.
Echo.    存在错误导致本程序无法继续。
Pause >nul
Exit