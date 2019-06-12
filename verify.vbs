Option Explicit

' Load external modules.
Dim vWscriptShell: Set vWscriptShell = CreateObject("WScript.Shell")

' Configure the message box title.
Dim vMsgBoxTitle: vMsgBoxTitle = "Heartbeat Checker"

' Read the submitted standard input.
Dim vInputString: vInputString = WScript.StdIn.ReadLine()

' Validate the format of the input string.
If Not IsNumeric(vInputString) Then
	Call MsgBox("The input is invalid.", 16, vMsgBoxTitle)
	Call Wscript.Quit()
End If

' Read the verification offset seconds value from the environment variable.
Dim vVerificationOffsetSecondsString: vVerificationOffsetSecondsString = _
	vWscriptShell.ExpandEnvironmentStrings("%APP_VERIFICATION_OFFSET_SEC%")

' Validate the format of the verification offset seconds string.
If Not IsNumeric(vVerificationOffsetSecondsString) Then
	Call MsgBox("The verification offset seconds parameter is invalid.", 16, vMsgBoxTitle)
	Call Wscript.Quit()
End If

' Compute the number of seconds since the last heartbeat timestamp.
Dim vTimeSinceLastHeartbeatSeconds: vTimeSinceLastHeartbeatSeconds = _
	DateDiff("s", DateSerial(1970, 1, 1), Now()) - CLng(vInputString)

' Check whether the number of seconds since the last heartbeat exceeds the number of verification offset seconds.
If vTimeSinceLastHeartbeatSeconds > CLng(vVerificationOffsetSecondsString) Then
	Call MsgBox("The heartbeat has been inactive for " _
		& CStr(Int(vTimeSinceLastHeartbeatSeconds / 3600)) & " hours, " _
		& CStr(Int(vTimeSinceLastHeartbeatSeconds / 60) Mod 60) & " minutes and " _
		& CStr(vTimeSinceLastHeartbeatSeconds Mod 60) & " seconds.", _
		48, vMsgBoxTitle)
End If
