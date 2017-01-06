; Name: citect-auto_hotkey.ahk
; Description: Shortcuts and macros for Vijeo Citect software

; Recommended default settings
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; ===
; Variables
; ===
; Alignment
clickDelay := 15
virtical := 25
horizontal := 150
center := 80
topLeft := 65
bottomRight := 95

; Reload with script suspended
suspend

; Reload AutoHotKey script
; Ctrl + Shift + r
^+r UP::
	; Allow this routine to be called while suspended
	suspend permit
	reload
return

; Suspend / Continue this AHK script
; Ctrl + Shift + s
^+s UP::
	; Allow this routine to be called while suspended
	suspend permit

	; Toggle suspend on this AHK script
	suspend toggle
return

; ===
; Edit Menu
; ===

; Toggle "lock mode"
; Ctrl + Shift + l
^+l UP::
        ; Open edit menu dropdown
        send !e
        
        ; Select "Break Lock Mode"
        send b
return

; Object properties
; Ctrl + Shift + p
^+p UP::
        ; Open edit menu dropdown
        send !e
        
        ; Highlight "ActiveX"
        send i
        
        ; Highlight "Properties"
        send i
        
        ; Select "Properties"
        send {enter}
return

; Select all objects
; Ctrl + Shift + a
^+a UP::
        ; Open edit menu dropdown
        send !e
        
        ; Select "Select All"
        send a
return

; ===
; Object Menu
; ===

; Place text
; Ctrl + Shift + t
^+t UP::
        ; Open object menu
        send !o
        
        ; Select "Text"
        send t
return

; ===
; Arange Menu
; ===

; Group objects
; Ctrl + Shift + g
^+g UP::
        ; Open arange menu dropdown
        send !a
        
        ; Select "Group Objects"
        send g
return

; Un-group objects
; Ctrl + Shift + u
^+u UP::
        ; Open arange menu dropdown
        send !a
        
        ; Select "Ungroup Objects"
        send u
return

; Bring object forward
; Ctrl + Shift + f
^+f UP::
        ; Open arange menu dropdown
        send !a
        
        ; Select "Bring Object Forward"
        send o
return

; Bring object forward
; Ctrl + Shift + b
^+b UP::
        ; Open arange menu dropdown
        send !a
        
        ; Select "Bring Object Backward"
        send c
return

; ===
; Alignment
; ===
; * Num-Lock must be OFF to use the following alignment commands

; Align "Center Center"
; NumPad5
NumPadClear UP::
	; Open alignment pop-up
	send ^a

	; Delay for window to open
	sleep %clickDelay%

	; Vertical center
	click left, %virtical%, %center%

	; Horizontal center
	click left, %horizontal%, %center%

	; Accept
	send {enter}
return

; Align "Vertical Top"
; NumPad8
NumPadUp UP::
	; Open alignment pop-up
	send ^a

	; Delay for window to open
	sleep %clickDelay%

	; Vertical top
	click left, %virtical%, %topLeft%

	; Accept
	send {enter}
return

; Align "Vertical Bottom"
; Numpad2
NumPadDown UP::
	; Open alignment pop-up
	send ^a

	; Delay for window to open
	sleep %clickDelay%

	; Vertical bottom
	click left, %virtical%, %bottomRight%

	; Accept
	send {enter}
return

; Align "Vertical Center"
; Numpad7
NumPadHome UP::
	; Open alignment pop-up
	send ^a

	; Delay for window to open
	sleep %clickDelay%

	; Vertical center
	click left, %virtical%, %center%

	; Accept
	send {enter}
return

; Align "Horizontal Left"
; NumPad4
NumPadLeft UP::
	; Open alignment pop-up
	send ^a

	; Delay for window to open
	sleep %clickDelay%

	; Horizontal left
	click left, %horizontal%, %topLeft%

	; Accept
	send {enter}
return

; Align "Horizontal Right"
; NumPad6
NumPadRight UP::
	; Open alignment pop-up
	send ^a

	; Delay for window to open
	sleep %clickDelay%

	; Horizontal right
	click left, %horizontal%, %bottomRight%

	; Accept
	send {enter}			
return

; Align "Horizontal Center"
; NumPad9
NumPadPgUp UP::
	; Open alignment pop-up
	send ^a

	; Delay for window to open
	sleep %clickDelay%

	; Horizontal center
	click left, %horizontal%, %center%

	; Accept
	send {enter}
return

; ===
; Arrange
; ===
^#!w::
	WinMinimizeAll
	
	SetTitleMatchMode, 2
	WinActivate, - Citect Explorer
	Sleep 50
	WinMove, A,, 0, 0, 450, (A_ScreenHeight) - 35
	
	;ControlGet, l, List, , SysListView321, A
	;MsgBox %l%
	
	WinActivate, Citect Project Editor
	Sleep 50
	WinMove, A,, 450, 0, (A_ScreenWidth) - 450, (((A_ScreenHeight) - 35)/2) - 200
	
	WinActivate, Citect Graphics Builder
	Sleep 50
	WinMove, A,, 450, (((A_ScreenHeight) - 35)/2) - 200, (A_ScreenWidth) - 450, (((A_ScreenHeight) - 35)/2) + 200
Return
