; Name: citect-auto_hotkey.ahk
; Description: Shortcuts and macros for Unity software

; Recommended default settings
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; ===
; Unity Export
; ===
^#!e::
	Loop {
		Send, {F2}
		Sleep, 250
		Send ^C
		Sleep, 250
		Send, {Alt}
		Sleep, 100
		Send, f
		Sleep, 100
		Loop, 6 {
			Send, {Down}
			Sleep, 100
		}
		Send, {Return}
		Sleep, 250
		
		; Export
		IfWinExist Export
		{
			WinActivate, Export
			Sleep, 100
			Click, Left, 50, 150
			Sleep, 100
			Send, UnityExport\
			Sleep, 100
			Send ^V
			Sleep, 100
			Send, {Return}
			Sleep, 2000
			Send, {Down}
			Sleep, 100
		}

		; End loop
		else
		{
			break
		}
	}
Return
