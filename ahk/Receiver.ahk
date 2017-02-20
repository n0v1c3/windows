; Example: Send a string of any length from one script to another.  This is a working example.
; To use it, save and run both of the following scripts then press Win+Space to show an
; InputBox that will prompt you to type in a string.

; Save the following script as "Receiver.ahk" then launch it:
#SingleInstance
OnMessage(0x4a, "Receive_WM_COPYDATA")  ; 0x4a is WM_COPYDATA
return

Receive_WM_COPYDATA(wParam, lParam)
{
    StringAddress := NumGet(lParam + 2*A_PtrSize)  ; Retrieves the CopyDataStruct's lpData member.
    CopyOfData := StrGet(StringAddress)  ; Copy the string out of the structure.
    ; Show it with ToolTip vs. MsgBox so we can return in a timely fashion:
    ToolTip %A_ScriptName%`nReceived the following string:`n%CopyOfData%
    return true  ; Returning 1 (true) is the traditional way to acknowledge this message.
}

