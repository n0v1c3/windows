'Author: Travis Gall
'File Name: FileNameGen.vbs
'Description: Generate a File's Save Name and Store on the Clipboard
'Date Modified: 2013/03/09

'==========USER INPUT==========
'Enter Job Number and Remove "-"(To be Connected to SQL Job Database)
JobNumber = Trim(UCase(Replace(InputBox("Enter Job Number:", "Job Number"),"-","")))

'Enter File Name
FileName = Trim(InputBox("Enter File Name:", "File Name"))

'Enter Initials and Ensure Uppercase
Initials = Trim(UCase(InputBox ("Enter Initials:", "Initials")))

'Save Date (Format YYMMDD)
curYear = Right(Year(Now()),2)
curMonth = Rounder(Month(Now()))
curDay = Rounder(Day(Now()))
SaveDate = curYear & curMonth & curDay

'==========CALCULATE SAVE NAME==========
'Concatenated Save Name
SaveName = JobNumber & "-" & FileName & "-" & SaveDate & "-" & Initials

'==========CLIPBOARD==========
'Create Shell Object
Set objShell = WScript.CreateObject("WScript.Shell")

'Store SaveName onto the Clipboard
objShell.Run "cmd /C echo|set /p=" & SaveName & "| CLIP", 2

Set ObjVoice = CreateObject("SAPI.SpVoice") 
StrText=("You can now paste your file name.")
ObjVoice.Speak StrText

'==========FUNCTIONS: ROUNDER()==========
'Ensure Integer String has at Least 2 Digits, Adding Leading Zero if Necessary
Function Rounder(num)
	'Add Leading Zero if Less than 10
	If (Len(num) = 1) Then
		Rounder = "0" & num
	'No Change Required
	Else
		Rounder = num
	End If
End Function


'==========TEST RUN 1==========
'JOBNUMBER-File Name-130309-TJG