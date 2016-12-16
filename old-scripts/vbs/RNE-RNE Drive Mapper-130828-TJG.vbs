Const Domain = ""

'Enter User Name
' UserName = Trim(InputBox("Enter User Name:", "User Name"))

'Add Required Domain if None is Found
'If InStr(1, UserName, "\") = 0 Then
'	UserName = Domain & UserName
'End If

'Enter Password
'Password = Trim(InputBox("Enter Password:", "Password"))

'Create Shell Object
Set objShell = WScript.CreateObject("WScript.Shell") 'Run CMDs

'Map Drives
UserName = "RNE_User"
Password = "user123"
objShell.Run "net use Z: ""\\192.168.227.5\rne"" /user:""" & UserName & """ """ & Password & """", 2

UserName = "user"
Password = "user123$"
objShell.Run "net use Y: ""\\192.168.227.2\Volume_1"" /user:""" & UserName & """ """ & Password & """", 2

'NOT USED
Function KeyExists(key)
	Dim objShell
	On Error Resume Next
	Set objShell = CreateObject("WScript.Shell")
		objShell.RegRead (key)
	Set objShell = Nothing
	If Err = 0 Then KeyExists = True
End Function