#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force ; Replace old script with new script without confirmation
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#+r::
Reload
Return

#+e::
; Get current mouse position relative to the entire screen
CoordMode, Mouse, Screen
MouseGetPos, MouseX, MouseY
CoordMode, Mouse, Window

; Select "Edit" from the right-click menu
Send, {Click Right}
Sleep, 100
MouseMove, 15, 150
Send, {Click Left}

; Return mouse to the original position
CoordMode, Mouse, Screen
MouseMove, MouseX, MouseY
CoordMode, Mouse, Window
Return

#+d::
; Get current mouse position relative to the entire screen
CoordMode, Mouse, Screen
MouseGetPos, MouseX, MouseY
CoordMode, Mouse, Window

; Select "Delete" from the right-click menu
Send, {Click Right}
Sleep, 100
MouseMove, 15, 125
Send, {Click Left}

; Return mouse to the original position
CoordMode, Mouse, Screen
MouseMove, MouseX, MouseY
CoordMode, Mouse, Window

; Finalize delete
Sleep, 250
Send, {Enter}
Return

#+p::
; Get current mouse position relative to the entire screen
CoordMode, Mouse, Screen
MouseGetPos, MouseX, MouseY
CoordMode, Mouse, Window

; Select "New" from the right-click menu
Send, {Click Right}
Sleep, 100
MouseMove, 15, 105
Send, {Click Left}

; Return mouse to the original position
CoordMode, Mouse, Screen
MouseMove, MouseX, MouseY
CoordMode, Mouse, Window

; Select "New Page"
Sleep, 100
Send, {Tab}
Sleep, 50
Send, {Enter}
Sleep, 500

; Select desired page template and finalize build
Send, O
Sleep, 100
Send, v
Sleep, 100
Send, {Enter}
Sleep, 100
Send, +{Tab}
Send, +{Tab}
Sleep, 100
Send, {Enter}
Return

#+t::
Send, {Alt}
Sleep, 100
Send, Y01 
Sleep, 100
Send, Y09
Return

#+l::
Send, {Alt}
Sleep, 100
Send, Y01 
Sleep, 100
Send, Y10
Return

/*
#+l::
Send, #r
Sleep, 100
Send, "C:\Program{Space}Files\VTScada\VTS.exe"{Enter}
Return
*/

#+q::
Send, #r
Sleep, 100
Send, TASKKILL /IM VTS.exe{Enter}
Return
