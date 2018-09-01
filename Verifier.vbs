vMsgBoxTitle = "HeartBeat Verifier"
vInputString = WScript.StdIn.ReadLine()

If Not IsNumeric(vInputString) Then
	Call MsgBox("The input is invalid.", 16, vMsgBoxTitle)
Else
	If (DateDiff("s", DateSerial(1970, 1, 1), Now()) - CLng(vInputString)) > 3600 Then
		Call MsgBox("The PC's heartbeat is inactive.", 16, vMsgBoxTitle)
	End if
End if
