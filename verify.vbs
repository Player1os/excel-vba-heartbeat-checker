' Configure the message box title.
vMsgBoxTitle = "Heartbeat Checker"

' Read the submitted standard input.
vInputString = WScript.StdIn.ReadLine()

' Validate the format of the read input string.
If Not IsNumeric(vInputString) Then
	Call MsgBox("The input is invalid.", 16, vMsgBoxTitle)
	Call Wscript.Quit()
End If

' Check whether the input string contains a timestamp from at most one hour ago.
If (DateDiff("s", DateSerial(1970, 1, 1), Now()) - CLng(vInputString)) > 3600 Then
	Call MsgBox("The PC's heartbeat is inactive.", 16, vMsgBoxTitle)
End If
