' Configure the message box title.
vMsgBoxTitle = "Heartbeat Checker"

' Read the submitted standard input.
vInputString = WScript.StdIn.ReadLine()

' Validate the format of the input string.
If Not IsNumeric(vInputString) Then
	Call MsgBox("The input is invalid.", 16, vMsgBoxTitle)
	Call Wscript.Quit()
End If

' Read the verification offset seconds value from the environment variable.
vVerificationOffsetSecondsString = CreateObject("WScript.Shell") _
	.ExpandEnvironmentStrings("%HEARTBEAT_CHECKER_VERIFICATION_OFFSET_SEC%")

' Validate the format of the verification offset seconds string.
If Not IsNumeric(vVerificationOffsetSecondsString) Then
	Call MsgBox("The verification offset seconds parameter is invalid.", 16, vMsgBoxTitle)
	Call Wscript.Quit()
End If

' Compute the number of seconds since the last heartbeat timestamp.
vSecondsSinceLastHeartbeat = DateDiff("s", DateSerial(1970, 1, 1), Now()) - CLng(vInputString)

' Check whether the number of seconds since the last heartbeat exceeds the number of verification offset seconds.
If vSecondsSinceLastHeartbeat > CLng(vVerificationOffsetSecondsString) Then
	Call MsgBox("The heartbeat has been inactive for " _
		& CStr(CLng(vSecondsSinceLastHeartbeat / 3600)) & " hours, " _
		& CStr(CLng((vSecondsSinceLastHeartbeat Mod 60) / 60)) & " minutes and " _
		& CStr(vSecondsSinceLastHeartbeat Mod 60) & " seconds.", _
		48, vMsgBoxTitle)
End If
