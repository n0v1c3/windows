#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance Force ; Replace old script with new script without confirmation

Gui, Add, Text, , Select the script to run;
; This function call builds the dropdown menu items
scriptList := Update()
Gui, Add, DropdownList, vscript, %scriptList%
;Gui, Add, Button, gOk wp, Run Script

~Esc::
Gui, Hide
Return

#+l::
Gui, Show, , AHK - Launcher
Return ; Shift+Win+l

; TODO [161219] - Use this to reload all active scripts
; Reload this script (to reload the other scripts simply relaunch them from the dropdown selector)
#+r::
Reload
Return ; Shift+Win+r

; Kill all running ahk scripts except for this script
#+q::
DetectHiddenWindows, On
WinGet, List, List, ahk_class AutoHotkey 

Loop %List% 
  { 
	; Get all ahk PIDs
    WinGet, PID, PID, % "ahk_id " List%A_Index% 
	; Skip this ahk script
    If ( PID <> DllCall("GetCurrentProcessId") )
		; Send kill command to the current PID
        PostMessage,0x111,65405,0,, % "ahk_id " List%A_Index% 
  }
Return ; Shift+Win+q

Ok:
Gui, Submit
Run %script%
Return

; Return a string prepared for a dropdown menu containing the scripts
Update()
{
	scriptList := ""
	isFirst := true
	
	Loop, %A_ScriptDir%\*.ahk
	{
		script := A_LoopFileName
		if (script != A_ScriptName)
		{
			; BUG [161219] - Blank row inserted if there is only one other script
			scriptList .= (isFirst ? script "|" : "|" script)
			isFirst := false
		}
	}
	Return scriptList
}


#IfWinActive AHK - Launcher
Enter::
	GoSub, Ok
Return ; Enter
#IfWinActive 