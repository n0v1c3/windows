; Name: launcher.ahk
; Description: AHK script launcher and manager
; Authors: Travis Gall

; AHK recommendations
#NoEnv 
SendMode Input

; Working directory relative to the script directory
SetWorkingDir %A_ScriptDir%
; Replace old script with new script without confirmation
#SingleInstance Force

; This function call builds the dropdown menu items
Gui, Add, Text, , Select the script to run;
scriptList := Update()
Gui, Add, DropdownList, vscript, %scriptList%

~Esc::
  Gui, Hide
Return

#+l::
  Gui, Show, , AHK - Launcher
Return ; Win+Shift+l

; Reload this script (to reload the other scripts simply relaunch them from the dropdown selector)
#+r::
  Reload
Return ; Win+Shift+r

; Kill all running ahk scripts except for this script
#+q::
  DetectHiddenWindows, On
  WinGet, List, List, ahk_class AutoHotkey

  Loop %List%
  {
    ; Get all ahk PIDs
    WinGet, PID, PID, % "ahk_id " List%A_Index%
    ; Send kill command to all ahk PIDs (except this one)
    If ( PID <> DllCall("GetCurrentProcessId") )
      PostMessage,0x111,65405,0,, % "ahk_id " List%A_Index%
  }
Return ; Win+Shift+q

Ok:
Gui, Submit
Run %script%
Return ; Ok

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
      scriptList .= (isFirst ? script "|" : "|" script)
      isFirst := false
    }
  }
  Return scriptList
} ; Update

#IfWinActive AHK - Launcher
Enter::
  GoSub, Ok
Return ; Enter
#IfWinActive
