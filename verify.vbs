Option Explicit

' Load external modules.
Dim vWscriptShell: Set vWscriptShell = CreateObject("WScript.Shell")
Dim vFileSystemObject: Set vFileSystemObject = CreateObject("Scripting.FileSystemObject")

' Define constants.
Const vVbCritical = 16

' Configure the message box title.
Dim vMsgBoxTitle: vMsgBoxTitle = "Heartbeat Checker"

' Read the submitted standard input.
Dim vInputString: vInputString = WScript.StdIn.ReadLine()

' Validate the format of the input string.
If Not IsNumeric(vInputString) Then
	Call MsgBox("The input is invalid.", vVbCritical, vMsgBoxTitle)
	Call Wscript.Quit()
End If

' Read the verification offset seconds value from the environment variable.
Dim vVerificationOffsetSecondsString: vVerificationOffsetSecondsString = _
	vWscriptShell.ExpandEnvironmentStrings("%APP_HEARTBEAT_CHECKER_VERIFICATION_OFFSET_SEC%")

' Validate the format of the verification offset seconds string.
If Not IsNumeric(vVerificationOffsetSecondsString) Then
	Call MsgBox("The verification offset seconds parameter is invalid.", vVbCritical, vMsgBoxTitle)
	Call Wscript.Quit()
End If

' Compute the number of seconds since the last heartbeat timestamp.
Dim vTimeSinceLastHeartbeatSeconds: vTimeSinceLastHeartbeatSeconds = _
	DateDiff("s", DateSerial(1970, 1, 1), Now()) - CLng(vInputString)

' Check whether the number of seconds since the last heartbeat exceeds the number of verification offset seconds.
If vTimeSinceLastHeartbeatSeconds < CLng(vVerificationOffsetSecondsString) Then
	' Determine the location of the project.
	Dim vProjectDirectoryPath : vProjectDirectoryPath = vFileSystemObject.GetParentFolderName(WScript.ScriptFullName)

	' Create the error input table file.
	With CreateObject("Excel.Application").Workbooks.Add()
		With .Worksheets(1)
			' Set the input table headers.
			.Range("A1").Value2 = "To"
			.Range("B1").Value2 = "CC"
			.Range("C1").Value2 = "BCC"
			.Range("D1").Value2 = "Subject"
			.Range("E1").Value2 = "Attachment"
			.Range("F1").Value2 = "Hours"
			.Range("G1").Value2 = "Minutes"
			.Range("H1").Value2 = "Seconds"

			' Set the recepient and subject of the email message.
			.Range("A2").Value2 = vWScriptShell.ExpandEnvironmentStrings("%APP_HEARTBEAT_CHECKER_ERROR_MAIL_RECIPIENT%")
			.Range("D2").Value2 = "[Heartbeat Checker] Verification had failed"

			' Set the time offsets.
			.Range("F2").Value2 = CStr(Int(vTimeSinceLastHeartbeatSeconds / 3600))
			.Range("G2").Value2 = CStr(Int(vTimeSinceLastHeartbeatSeconds / 60) Mod 60)
			.Range("H2").Value2 = CStr(vTimeSinceLastHeartbeatSeconds Mod 60)
		End With

		Call .SaveAs(vProjectDirectoryPath & "\error_mail_input_table.xlsx")
		Call .Close(False)
	End With

	' Set the mail sender parameters.
	With vWscriptShell.Environment("PROCESS")
		.Item("APP_IS_AUTORUN_MODE") = "TRUE"
		.Item("APP_INPUT_TABLE_FILE_PATH") = vProjectDirectoryPath & "\error_mail_input_table.xlsx"
		.Item("APP_BODY_TEMPLATE_FILE_PATH") = vProjectDirectoryPath & "\error_mail_body_template.txt"
	End With

	' Disable error handling.
	On Error Resume Next

	' Run the main project workbook.
	Call CreateObject("Excel.Application").Workbooks.Open( _
		vWscriptShell.ExpandEnvironmentStrings("%APP_HEARTBEAT_CHECKER_EXCEL_MAIL_SENDER_PATH%") _
	)

	' Remove the error input table file.
	Call vFileSystemObject.DeleteFile(vProjectDirectoryPath & "\error_mail_input_table.xlsx")

	' Check whether reporting the error was finished without error, otherwise display a message box to the user.
	If Err.Number <> 0 Then
		Call MsgBox("An unexpected error had occured while attemtping to report a verification failure.", vVbCritical, vMsgBoxTitle)
	End If

	' Reenable error handling.
	On Error Goto 0
End If
