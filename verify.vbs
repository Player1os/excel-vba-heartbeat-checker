' Configure the message box title.
vMsgBoxTitle = "Heartbeat Checker"

' Read the submitted standard input.
vInputString = WScript.StdIn.ReadLine()

' Validate the format of the read input string.
If Not IsNumeric(vInputString) Then
	Call MsgBox("The input is invalid.", 16, vMsgBoxTitle)
	Call Wscript.Quit()
End If

	Call MsgBox("The heartbeat has been inactive for " _
		& CStr(CLng(vSecondsSinceLastHeartbeat / 3600)) & " hours, " _
		& CStr(CLng((vSecondsSinceLastHeartbeat Mod 60) / 60)) & " minutes and " _
		& CStr(vSecondsSinceLastHeartbeat Mod 60) & " seconds.", _
		48, vMsgBoxTitle)
End If
