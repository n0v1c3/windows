#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force ; Replace old script with new script without confirmation
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Gui, Add, Text, , Select the script to run;
; This function call builds the dropdown menu items
scriptList := Update()
Gui, Add, DropdownList, vwhattodo, %scriptList%
Gui, Add, Button, gOk wp, Ok

Esc::
Gui, Hide
Return

#+l::
Gui, Show, , AHK - Launcher
Return ; Shift+Win+l

; TODO [161219] - Use this to reload all active scripts
#+r::
Reload
Return ; Shift+Win+r

#+q::
DetectHiddenWindows, On 
WinGet, List, List, ahk_class AutoHotkey 

Loop %List% 
  { 
    WinGet, PID, PID, % "ahk_id " List%A_Index% 
    If ( PID <> DllCall("GetCurrentProcessId") ) 
         PostMessage,0x111,65405,0,, % "ahk_id " List%A_Index% 
  }
  
Return ; Shift+Win+q

Ok:
Gui, Submit
Run %whattodo%
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