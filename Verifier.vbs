Set vHeartBeatFile = CreateObject("Scripting.FileSystemObject").OpenTextFile("H:\HeartBeat.txt", 1)
vHeartBeatFileContent = vHeartBeatFile.ReadAll()
Call vHeartBeatFile.Close()
Set vHeartBeatFile = Nothing

If (DateDiff("s", DateSerial(1970, 1, 1), Now()) - CLng(vHeartBeatFileContent)) > 3600 Then
	Call MsgBox("The PC's heartbeat is inactive.", 16, "HeartBeat Checker")
End if
