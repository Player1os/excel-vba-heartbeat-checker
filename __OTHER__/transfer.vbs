vDatabase
vDBUsername
vDBPassword

vHueBaseURL
vUsername
vPassword

vQuery
vHDFSFilePath

Dim vFileName As String
Dim vHDFSDirectoryPath As String
Dim vStream As ADODB.Stream
Dim vData() As Byte

With Runtime.FileSystemObject()
	vFileName = .GetFileName(vHDFSFilePath)
	vHDFSDirectoryPath = .GetParentDirectory(vHDFSFilePath)
End With

With New ClsDBConnection
	Call .ConnectOracle(vDatabase, vDBUsername, vDBPassword)
	Set vStream = .Execute(vDBQuery).OutputToBinaryStream()
	vData = vStream.Read()
	Call vStream.Close
End With
Set vStream = Nothing

With New ClsHDFSConnection
	.vHueBaseURL = vHueBaseURL
	.vUsername = vUsername
	.vPassword = vPassword
	
	Call .Delete(vHDFSFilePath)
	Call .UploadBytes(vData, vFileName, vHDFSDirectoryPath)
	'Call .SetPermissions(vHDFSFilePath, "rw-r--r----")
End With
