@Echo off
Goto :%*


:ScanBehaRe
Set "Warnning.Level.Num="
For %%a in (%Info1%%Info2%%Info3%) do (
	If DEFINED %%a (
		Set "%%a="
	)
)
For /l %%z in (1,1,9) do (
	For /l %%y in (1,1,9) do (
		For /l %%a in (1,1,10) do (
			If DEFINED Warnning.By%%z%%y0%%a (
				Set "Warnning.By%%z%%y0%%a="
			)
		)
	)
)
Goto :Eof