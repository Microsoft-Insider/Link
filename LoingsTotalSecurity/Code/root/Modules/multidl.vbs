Option Explicit
Dim ado
Dim fso
Dim whtp
Dim i
Set ado  = CreateObject("adodb.stream")
Set fso  = CreateObject("scripting.filesystemobject")
Set whtp = CreateObject("winhttp.winhttprequest.5.1")

If wsh.arguments.count < 2 Then
	wsh.echo "vbs多线下载+断点续传工具" + vbCrLf + _
		 "用法: multidl [outfile] [url]" + vbCrLf + _
		 "建议用cscript打开，像" + vbCrLf + _
		 "cscript /nologo multidl [outfile] [url]"
Else
	multidl wsh.arguments(1),wsh.arguments(0),16
End If

Function multidl(byval url,byval dst,byval maxn)
	Dim http()
	Dim hsta()
	Dim hlen()
	Dim htim()

	Dim nsta
	Dim nlen
	Dim nprg
	Dim tlen

	Dim rprg
	Dim rtim
	Dim rspd
	Dim rsav

	Dim etim

	'' init ''
	ado.mode = 3
	ado.type = 1
	ado.open

	ReDim http(maxn - 1),hsta(maxn - 1),hlen(maxn - 1),htim(maxn - 1)

	For i = 0 To maxn - 1
		Set http(i) = CreateObject("msxml2.xmlhttp")
		hsta(i)     =  - 1
		hlen(i)     =  - 1
		htim(i)     =  - 1
	Next

	nsta = 0
	nlen = 4096
	tlen = 0

	Dim loc
	loc = url

	whtp.Option(6) = False

	Do While loc <> ""
		url = loc
		whtp.open "head",url,False
		header whtp
		whtp.send

		loc = ""
		On Error Resume Next
		loc = whtp.getresponseheader("location")
		On Error goto 0
	Loop

	'' start ''

	If fso.fileexists(dst + ".tmp")And fso.fileexists(dst + ".prg")Then
		multiload dst,hsta,hlen,nsta,tlen
	Else

		Select Case multistart(url,dst,tlen)
			Case 1
				multidl = 1
				Exit Function
			Case 2
				multidl = download(url, dst)
				Exit Function
		End Select

		multisave dst,hsta,hlen,nsta,tlen
	End If

	nprg = nsta

	For i = 0 To maxn - 1
		If hlen(i) <> - 1 Then nprg = nprg - hlen(i)
	Next

	rprg = nprg
	rtim = timer()
	rspd = 0
	rsav = 500
	etim = rtim

	'' main ''

	Do While nprg < tlen

		For i = 0 To maxn - 1

			If htim(i) =  - 1 Then

				If timer() > etim Then

					If hsta(i) =  - 1 Then

						If nsta < tlen Then
							If nlen > tlen - nsta Then nlen = tlen - nsta
							hsta(i) = nsta
							hlen(i) = nlen
							htim(i) = timer()
							nsta    = nsta + nlen
							multirange http(i),url,hsta(i),hlen(i)
							Exit For
						End If

					Else
						multirange http(i),url,hsta(i),hlen(i)
						htim(i) = timer()
						Exit For
					End If

				End If

			Else

				If http(i).readystate = 4 Then

					If http(i).status < 200 Or http(i).status > 299 Then

						nlen         = Int(hlen(i)/(timer() - htim(i)) + 512)
						etim         = timer() + 5
						htim(i)      =  - 1
					Else
						ado.position = hsta(i)
						ado.Write http(i).responsebody
						nprg         = nprg + hlen(i)
						nlen         = Int(hlen(i)/(timer() - htim(i)) + 512)

						If timer() - rtim > 1 Then
							rspd = (nprg - rprg)/(timer() - rtim)
							rtim = timer()
							rprg = nprg
						End If

						hsta(i) =  - 1
						hlen(i) =  - 1
						htim(i) =  - 1
						i       = i - 1
					End If

				End If

			End If

		Next

		Dim lcnt
		lcnt = 0

		For i = 0 To maxn - 1
			If htim(i) <> - 1 Then lcnt = lcnt + 1
		Next

		rsav = rsav - 1

		If rsav = 0 Then
			multisave dst,hsta,hlen,nsta,tlen
			rsav = 500
		End If

		On Error Resume Next
		wsh.stdout.Write "已下载: " + szfmt(nprg) + "	总共: " + szfmt(tlen) + "	" + CStr(lcnt) + "Ls	速度: " + szfmt(rspd) + "/s	" + String(10," ") + Chr(13)
		On Error Goto 0
		wsh.sleep 1
	Loop

	multisave dst,hsta,hlen,nsta,tlen
	'' close ''
	fso.copyfile dst + ".tmp",dst,True
	fso.deletefile dst + ".prg"
	fso.deletefile dst + ".tmp"
	ado.Close
End Function

Sub multirange(byref http,byval url,byval sta,byval Len)
	http.open "get",url,True
	header http
	http.setrequestheader "range", "bytes=" + CStr(sta) + "-" + CStr(sta + Len - 1)
	http.send
End Sub

Function multistart(byval url,byval dst,byref tlen)
	Dim str
	str = ""
	On Error Resume Next
	str = whtp.getresponseheader("content-length")
	On Error goto 0

	If str = "" Then
		multistart = 2
	Else
		tlen      = CDbl(str)

		Dim fp
		Set fp = fso.CreateTextFile(dst + ".tmp",True,False)
		fp.Write String(tlen," ")
		fp.Close

		ado.loadfromfile dst + ".tmp"

		multistart = 0
	End If

End Function

Sub multiload(byval dst,byref hsta(),byref hlen(),byref nsta,byref tlen)
	Dim fp
	Set fp = fso.OpenTextFile(dst + ".prg")

	For i = 0 To UBound(hsta)
		hsta(i) = CDbl(fp.ReadLine())
		hlen(i) = CDbl(fp.ReadLine())
	Next

	nsta = CDbl(fp.ReadLine())
	fp.Close

	ado.loadfromfile dst + ".tmp"
End Sub

Sub multisave(byval dst,byval hsta(),byval hlen(),byval nsta,byval tlen)
	Dim fp
	Set fp = fso.CreateTextFile(dst + ".prg",True,False)

	For i = 0 To UBound(hsta)
		fp.WriteLine hsta(i)
		fp.WriteLine hlen(i)
	Next

	fp.WriteLine nsta
	fp.Close

	ado.savetofile dst + ".tmp", 2
End Sub

Sub header(byref http)
	http.setrequestheader "Connection","Keep-Alive"
	http.setrequestheader "Content-Length","0"
	http.setrequestheader "Accept","*/*"
	http.setrequestheader "User-Agent","Wget/1.19.4 (mingw32)"
End Sub

''''''''''''''''''''''''''''''''''''''''''''''''''
Function download(url,target)
	Dim http
	Set http = CreateObject("msxml2.xmlhttp")
	http.open "get",url,False
	http.send

	If http.status < 200 Or http.status > 299 Then
		download = 1
		Exit Function
	End If

	ado.type = 1
	ado.Write http.responsebody
	ado.savetofile target, 2
	ado.Close
	download = 0
End Function

Function szfmt(byval val)
	Dim l
	Dim k
	l = 1

	Do While val >= 1024 And l < 4
		val = val/1024
		l   = l + 1
	Loop

	If val < 10 Then
		k = 100
	ElseIf val < 100 Then
		k = 10
	Else
		k = 1
	End If

	szfmt = CStr(Int(val*k)/k) + Mid("bkmg",l,1)
End Function
