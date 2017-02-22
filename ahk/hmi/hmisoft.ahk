#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

InputBox, tagNew, "Enter new Tag:"

; Close all windows
#+q::
Send {Alt}
Send w
Loop 1
	Send {Down}
Send {Enter}
Return

; Zoom in
#WheelUp::
Send {Alt}
Send v
Loop 5
	Send {Down}
Send {Enter}
Return

; Zoom out
#WheelDown::
Send {Alt}
Send v
Loop 6
	Send {Down}
Send {Enter}
Return

#+c::
Click, 245, 730
Send, ^c
StringReplace, clipboard, clipboard, %clipboard%, HMI_%clipboard%_CMD, All
Send, ^v
Send, {Tab}
Return

#+y::
Send, ^c
Sleep, 100
MsgBox % SubStr(clipboard, 1,StrLen(clipboard) - 4)
Return

; Remove old tag crap
#+z::
Click, 230, 725
Sleep, 100
Send, ^a
Sleep, 100
Send, ^c
Sleep, 100
StringReplace, clipboard, clipboard, _START_, _ST_
StringReplace, clipboard, clipboard, _STOP_, _SP_
StringReplace, clipboard, clipboard, _SEQUENCE_, _SEQ_
Send, ^v
Sleep, 100
Send, {Enter}

/*
Click, 230, 750
Sleep, 100
Send, ^a
Sleep, 100
Send, ^c
Sleep, 100
Send, +{Tab}
Sleep, 100
Send, +{Tab}
Sleep, 100
StringReplace, clipboard, clipboard, _BYPASSED, _BYP_ON_CMD
StringReplace, clipboard, clipboard, %clipboard%, HMI_%clipboard%
Send, ^v
Sleep, 100
Send, {Enter}
*/
/*
;tagNew = TIT_100
Click, 230, 725
Sleep, 100
Send, ^a
Sleep, 100
Send, ^c
tagOld := % SubStr(clipboard, 1,StrLen(clipboard) - 4)
Sleep, 100
StringReplace, clipboard, clipboard, %tagOld%, %tagNew%, All 
Send, ^v
Sleep, 100
Send, {Tab}
Sleep, 100
Click, 200, 700
Sleep, 100
Send, {Down}
Sleep, 100
Send, {Down}
Sleep, 100
Send, {Enter}
Sleep, 100

Loop, 3
{
Click, 230, 725
Sleep, 250
	Loop, 2	
	{
		Send, ^c
		Sleep, 100
		IfNotInString, clipboard, None
			{
			StringReplace, clipboard, clipboard, %tagOld%, %tagNew%, All
			Send, ^v
			Sleep, 100
			Send, ^a
			Sleep, 100
			Send, ^c
			Sleep, 100
			IfNotInString, clipboard, _ENG
			{
				IfNotInString, clipboard, _BYP
				{
					StringReplace, clipboard, clipboard, %clipboard%, HMI_%clipboard%
					StringReplace, clipboard, clipboard, HMI_HMI_, HMI_

				}
			}
			;Click, 230, 725
			Send, ^a
			Sleep, 100
			Send, ^v
			Sleep, 100
			
			Send, {Tab}
			Send, {Tab}
		}
	}
	Send, {Tab}
	Sleep, 500
	Send, {Alt Down}
	Send, {Tab}
	Sleep, 100
	Send, {Esc}
	Sleep, 100
	Send, {Alt Up}
	Sleep, 100
	Send, {Tab}
	Sleep, 100
}
*/
/*
Click, 245, 730
Loop, 2
{
	Send, ^c
	Sleep, 100
	StringReplace, clipboard, clipboard, FQ_, FT_, All
	StringReplace, clipboard, clipboard, _OP_CMD, _OPEN_CMD, All
	StringReplace, clipboard, clipboard, _CL_CMD, _CLOSE_CMD, All
	IfInString, clipboard, _CMD
	{
		IfNotInString, clipboard, HMI_
		{
			StringReplace, clipboard, clipboard, %clipboard%, HMI_%clipboard%
		}
	}
	Send, ^v
	Sleep, 100
	Send, {Tab}
	Send, {Tab}
}
*/
/*
Send, ^c
Sleep, 100
StringReplace, clipboard, clipboard, DQ_, DT_, All
IfInString, clipboard, HMI_
{
	StringReplace, clipboard, clipboard, HMI_, , All
	StringReplace, clipboard, clipboard, _CMD, , All
}
IfInString, clipboard, ST_P
{
	StringReplace, clipboard, clipboard, ST_P, P, All
	StringReplace, clipboard, clipboard, _ENG, _SP_ENG, All
}
Send, ^v
Send, {Tab}
Send, {Tab}
Sleep, 100
Send, ^c
StringReplace, clipboard, clipboard, DQ_, DT_, All
IfInString, clipboard, HMI_
{
	StringReplace, clipboard, clipboard, HMI_, , All
	StringReplace, clipboard, clipboard, _CMD, , All
}
IfInString, clipboard, ST_P
{
	StringReplace, clipboard, clipboard, ST_P, P, All
	StringReplace, clipboard, clipboard, _ENG, _SP_ENG, All
}
Send, ^v
Click
*/
/* TX
tagNameOld := "PIT"
tagNameNew := "BSW"
tagLoopOld := "163S"
tagLoopNew := "300"
Click 320, 650
Sleep 100
Send ^c
StringReplace, clipboard, clipboard, %tagNameOld%_%tagLoopOld%, %tagNameNew%_%tagLoopNew%, All
StringReplace, clipboard, clipboard, _TO_HMI, , All
StringReplace, clipboard, clipboard, HMI_, , All
Send ^v
Sleep 100
Send {Tab}
Send {Tab}
Send ^c
Sleep 100
StringReplace, clipboard, clipboard, %tagNameOld%_%tagLoopOld%, %tagNameNew%_%tagLoopNew%, All
StringReplace, clipboard, clipboard, _TO_HMI, , All
StringReplace, clipboard, clipboard, HMI_, , All
Sleep 100
Send ^v
Sleep 100
Send {Enter}
Sleep 100
*/
/* CALIBRATION
tagNameOld := "PIT"
tagNameNew := "H2S"
tagLoopOld := "163S"
tagLoopNew := "100"
tagEngOld := "kPa"
tagEngNew := "mA"
Click 320, 650
Sleep 100
Send ^c
Sleep 100
StringReplace, clipboard, clipboard, %tagNameOld%_%tagLoopOld%, %tagNameNew%_%tagLoopNew%, All
StringReplace, clipboard, clipboard, HMI_, , All
StringReplace, clipboard, clipboard, _TO_HMI, , All
Sleep 100
Send ^v
Sleep 100
Send {Tab}
Send {Tab}
Send ^c
Sleep 100
StringReplace, clipboard, clipboard, %tagNameOld%_%tagLoopOld%, %tagNameNew%_%tagLoopNew%, All
StringReplace, clipboard, clipboard, _TO_HMI, , All
Sleep 100
Send ^v
Send {Enter}
*/
/* BOOSTER
tagNameOld := "B"
tagNameNew := "P"
tagLoopOld := 1
tagLoopNew := 3
Click 320, 650
Sleep 100
Send ^c
Sleep 100
StringReplace, clipboard, clipboard, %tagNameOld%%tagLoopOld%, %tagNameNew%%tagLoopNew%, All
StringReplace, clipboard, clipboard, _TO_HMI, , All
Sleep 100
Send ^v
Send {Enter}
*/
/* SAMPLE
tagNameOld := "SMP"
tagNameNew := "SMP"
tagLoopOld := 120
tagLoopNew := 301
Click 320, 650
Send ^c
Sleep 100
StringReplace, clipboard, clipboard, %tagNameOld%%tagLoopOld%, %tagNameNew%%tagLoopNew%, All
StringReplace, clipboard, clipboard, _TO_HMI, , All
Send ^v
Sleep 100
Send {Tab}
Send {Tab}
Sleep 100
Send ^c
Sleep 100
StringReplace, clipboard, clipboard, %tagNameOld%%tagLoopOld%, %tagNameNew%%tagLoopNew%, All
StringReplace, clipboard, clipboard, _TO_HMI, , All
Send ^v
Sleep 100
Send {Enter}
*/
/* METER
Click 320, 650
Sleep 100
Send ^c
Sleep 100
StringReplace, clipboard, clipboard, 100, 303, All
Sleep 100
Send ^v
Sleep 100
Send {Tab}
Send {Tab}
Send ^c
Sleep 100
StringReplace, clipboard, clipboard, 100, 303, All
Send ^v
Send {Enter}
*/
/* PIDs
Click 320, 650
Send ^c
Sleep 100
StringReplace, clipboard, clipboard, 100, 400, All
StringReplace, clipboard, clipboard, P1, P4, All
Sleep 100
Send ^v
Sleep 100
Send {Tab}
Send {Tab}
Sleep 100
Send ^c
Sleep 100
StringReplace, clipboard, clipboard, 100, 400, All
StringReplace, clipboard, clipboard, P1, P4, All
Sleep 100
Send ^v
Send {Enter}
*/
/* VALVE
tagNameOld := "POV"
tagNameNew := "POV"
tagLoopOld := 201
tagLoopNew := 300
Click 320, 650
Send ^c
StringReplace, clipboard, clipboard, HMI_, , All
StringReplace, clipboard, clipboard, %tagNameOld%%tagLoopOld%, %tagNameNew%_%tagLoopNew%, All
StringReplace, clipboard, clipboard, %tagNameOld%_%tagLoopOld%, %tagNameNew%_%tagLoopNew%, All
StringReplace, clipboard, clipboard, ZSO_%tagLoopOld%, %tagNameNew%_%tagLoopNew%_ZSO, All
StringReplace, clipboard, clipboard, _OPEN_, _OP_, All
StringReplace, clipboard, clipboard, _CLOSE_, _CL_, All
StringReplace, clipboard, clipboard, ZSC_%tagLoopOld%, %tagNameNew%_%tagLoopNew%_ZSC, All
StringReplace, clipboard, clipboard, _STATE, _STS, All
StringReplace, clipboard, clipboard, _TO_HMI, , All
Send ^v
Send {Enter}
*/
/* SPs
tagNameOld := "AIT"
tagNameNew := "H2S"
tagLoopOld := 101
tagLoopNew := 100
Click 320, 650
Send ^c
StringReplace, clipboard, clipboard, %tagNameOld%_%tagLoopOld%, %tagNameNew%_%tagLoopNew%, All
Send ^v
Send {Tab}
Send {Tab}
Send ^v
Send {Enter}
*/
/* METER
Send ^c
StringReplace, clipboard, clipboard, FQI100, FQI200, All
StringReplace, clipboard, clipboard, FQ_100, FQ_200, All
StringReplace, clipboard, clipboard, DQ_100, DQ_200, All
Send ^v
Send {Enter}
*/
Return

; Remove old tag crap
#+x::
Click 320, 650
Sleep 100
Send {Right}
Loop 7
	Send {Backspace}
Send {Enter}
Return

; Replace old memory address with new memory addresses
#+m::
DetectHiddenText, On
Click 280, 730
Sleep 100
Click 280, 730
Sleep 500
WinActive("Input")
Sleep, 100
Send ^c
WinGetText, text, Input
Sleep 100
IfInString, text, W4-
	prefix := "W4-"
IfInString, text, B0-
	prefix := "B0-"
clipboard = %prefix%%clipboard%
WinActivate, Microsoft Excel - ppl026-tag_builder.xlsm
Sleep, 100
Click 400, 220
Send, ^f
Send, ^v
Send, {Enter}
Sleep, 100
Send, {Esc}
Sleep, 100
Send, {Right}
Send, {Right}
Send, {Right}
Send, ^c
WinActivate, Input
Sleep, 100
Send, ^v
Return

#+w::
Loop 40
{
	Send !D
}
Return

#+r::
Reload
Return


; Remove old tag crap
#+t::
tagNew = P2_SP
Click, 230, 725
Sleep, 100
Send, ^c
tagOld := % SubStr(clipboard, 1,StrLen(clipboard) - 4)
Sleep, 100
StringReplace, clipboard, clipboard, %tagOld%, %tagNew%, All
Send, ^v
Sleep, 100
Send, {Tab}
Sleep, 100
Click, 200, 700
Sleep, 100
Send, {Down}
Sleep, 100
Send, {Down}
Sleep, 100
Send, {Enter}
Sleep, 100

Loop, 8
{
Click, 230, 725
Sleep, 250
	Loop, 2	
	{
		Send, ^c
		Sleep, 100
		IfNotInString, clipboard, None
			{
			StringReplace, clipboard, clipboard, %tagOld%, %tagNew%, All
			Send, ^v
			Sleep, 100
			Send, ^a
			Sleep, 100
			Send, ^c
			Sleep, 100
			IfNotInString, clipboard, _ENG
			{
				StringReplace, clipboard, clipboard, %clipboard%, HMI_%clipboard%
				StringReplace, clipboard, clipboard, HMI_HMI_, HMI_
			}
			;Click, 230, 725
			Send, ^a
			Sleep, 100
			Send, ^v
			Sleep, 100
			
			Send, {Tab}
			Send, {Tab}
		}
	}
	Send, {Tab}
	Sleep, 500
	Send, {Alt Down}
	Send, {Tab}
	Sleep, 100
	Send, {Esc}
	Sleep, 100
	Send, {Alt Up}
	Sleep, 100
	Send, {Tab}
	Sleep, 100
}
Return
