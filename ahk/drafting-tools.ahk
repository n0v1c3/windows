#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force ; Replace old script with new script without confirmation
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

OnExit, ExitSub

DLL_SPI := "SystemParametersInfo"
DLL_SPI_GETMOUSESPEED = 0x70
DLL_SPI_SETMOUSESPEED = 0x71

; ---
; Mouse
; ---

MOUSE_MIN := 3
MOUSE_OVERRIDE_ENABLED_INIT := 0

; Retrieve the current speed so that it can be restored later:
DllCall(DLL_SPI, UInt, DLL_SPI_GETMOUSESPEED, UInt, 0, UIntP, mouseSensitivityOriginal, UInt, 0)
mouseOverrideEnabled := MOUSE_OVERRIDE_ENABLED_INIT

; ===
; Functions
; ===

; Adjust the current mouse speed accordig to the value of mouseOverrideEnabled
SetMouseSpeed:
DllCall(DLL_SPI, UInt, DLL_SPI_SETMOUSESPEED, UInt, 0, UInt, (mouseOverrideEnabled ? MOUSE_MIN : mouseSensitivityOriginal), UInt, 0) 
Return ; SetMouseSpeed

F1::
mouseOverrideEnabled := !mouseOverrideEnabled
Goto SetMouseSpeed
Return ; F1

F3::
Send {F2}
Sleep 1
Send {Shift down}{Ctrl down}
Sleep 1
Send {End}
Sleep 1
Send {Shift up}{Ctrl up}
Sleep 1
Send ^v
Sleep 1
Send {F2}
Return ; F3

F4::
Send {Right}
Sleep 1
Send ^v
Sleep 1
Send {F2}
Return ; F4

ExitSub:
; Set mouse back to the initial speed
mouseOverrideEnabled := MOUSE_OVERRIDE_ENABLED_INIT
Goto SetMouseSpeed

; Exit application
ExitApp
Return ; ExitSub
