Option Explicit

' Load external modules.
Dim vFileSystemObject: Set vFileSystemObject = CreateObject("Scripting.FileSystemObject")

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

		' Set the recepient and subject of the email message.
		.Range("A2").Value2 = "To"
		.Range("D2").Value2 = "Subject"
	End With

	Call .SaveAs(vProjectDirectoryPath & "\error_mail_input_table.xlsx")
	Call .Close(False)
End With
