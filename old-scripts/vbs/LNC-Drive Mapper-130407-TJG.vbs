Const Domain = "Concise\"

'Enter User Name
UserName = Trim(InputBox("Enter User Name:", "User Name"))

'Add Required Domain if None is Found
If InStr(1, UserName, "\") = 0 Then
	UserName = Domain & UserName
End If

'Enter Password
Password = Trim(InputBox("Enter Password:", "Password"))

'Create Shell Object
Set objShell = WScript.CreateObject("WScript.Shell") 'Run CMDs

'Map Drives
objShell.Run "net use I: ""\\192.168.123.240\Engineering\Projects"" /user:""" & UserName & """ """ & Password & """", 2
objShell.Run "net use P: ""\\192.168.123.241\Programs"" /user:""" & UserName & """ """ & Password & """", 2
objShell.Run "net use S: ""\\192.168.123.241\Stuff"" /user:""" & UserName & """ """ & Password & """", 2
objShell.Run "net use V: ""\\192.168.123.241\Engineering\Projects"" /user:""" & UserName & """ """ & Password & """", 2
objShell.Run "net use W: ""\\192.168.123.241\Engineering\PLC"" /user:""" & UserName & """ """ & Password & """", 2
objShell.Run "net use X: ""\\192.168.123.241\Drawing_Control"" /user:""" & UserName & """ """ & Password & """", 2

'NOT USED
Function KeyExists(key)
	Dim objShell
	On Error Resume Next
	Set objShell = CreateObject("WScript.Shell")
		objShell.RegRead (key)
	Set objShell = Nothing
	If Err = 0 Then KeyExists = True
End Function