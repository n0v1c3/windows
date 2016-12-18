; Routine: magnifier.ahk
; Description: On screen magnifier that follows the cursor on the screen
; Author: Travis Gall

; ===
; Initialize
; ===

; Recommended for performance and compatibility with future AutoHotkey releases
#NoEnv

; Set coordinate mode to affect (MouseGetPos, Click, and MouseMove/Click/Drag) all relative to the entire screen
CoordMode Mouse, Screen

; ===
; Constants
; ===

; ---
; Antializing
; ---

ANTIALIZE_INIT := 1

; ---
; DLLs
; ---

; SystemParametersInfo
DLL_SPI := "SystemParametersInfo"
DLL_SPI_MOUSESPEED = 113

; ---
; Mouse
; ---

MOUSE_SPEED_INIT := 10

; ---
; Window
; ---

GUI_WIN_BACKGROUND := ffffff
GUI_WIN_COMP_BACKGROUND := f3ffff
GUI_WIN_INIT_OFFSET := 10000
GUI_WIN_WIDTH_INIT := 128
GUI_WIN_HEIGHT_INIT := 128
GUI_WIN_REPAINT_DELAY_INIT := 1
GUI_WIN_MOUSE_OFFSET_INIT := 25
GUI_WIN_MOUSE_OFFSET_ADJUST := 8
GUI_WIN_ENABLED_INIT := 1
GUI_WIN_FROZEN := 0
GUI_WIN_NAME_INIT := "Magnifier"

; ---
; Zoom
; ---

ZOOM_LEVEL_INIT := 2

; ===
; Variables
; ===

; ---
; Antializing
; ---

; 1 = On, 0 = Off
antialize := ANTIALIZE_INIT

; ---
; Mouse
; ---

; Range {1..20}
MouseSpeed := MOUSE_SPEED_INIT

; ---
; Windown
; ---

winWidth := GUI_WIN_WIDTH_INIT
winHeight := GUI_WIN_HEIGHT_INIT
winMouseOffsetX := GUI_WIN_MOUSE_OFFSET_INIT
winMouseOffsetY := GUI_WIN_MOUSE_OFFSET_INIT
winName := GUI_WIN_NAME_INIT
winEnabled := GUI_WIN_ENABLED_INIT
winFrozen := GUI_WIN_FROZEN
winRepaintDelay := GUI_WIN_REPAINT_DELAY_INIT

; ---
; Zoom
; ---

zoom :=  ZOOM_LEVEL_INIT

; ===
; GUI
; ===

; Create a window to display magnification
Gui +E0x20 -Caption +AlwaysOnTop -Resize +ToolWindow
Gui Color, %GUI_WIN_BACKGROUND%, %GUI_WIN_COMP_BACKGROUND%

; Display window, initialize off screen to prevent "flicker"
Gui Show, % "w" winWidth " h" winHeight " x-"winMouseOffsetX " y-"winMouseOffsetY, %winName%

; Get window ID information for the magnifier and screen
WinGet winID, id,  %winName%
WinGet screenID, id

; Configure window, components, and screen for transparancy
;WinSet Transparent, 0, %winName%;%WindowTrans%, %winID% ; Confirm what this line was doing
WinSet TransColor, %GUI_WIN_COMP_BACKGROUND%, %winID%
WinSet TransColor, %GUI_WIN_COMP_BACKGROUND%, %screenID%

; Adjust shape of the window
;WinSet, Region, 10-30 W128 H128 E, %winName%

; Get handles to the device context (DC) for the window and screen
winDC := DllCall("GetDC", UInt, winID)
screenDC := DllCall("GetDC", UInt, screenID)

; ===
; Repaint Loop
; ===

Repaint:
	; Get current cursor position
	MouseGetPos mouseX, mouseY
	
	; TODO
	; Adjust mouse speed based on zoom level
	;DllCall(%DLL_SPI%, Int, %DLL_SPI_MOUSESPEED%, Int, 0, UInt, %MouseSensitivity%, Int, 2)

	if (!winFrozen) {		
		; Posision window beside the cursor
		WinMove, %winName%, , (mouseX + winMouseOffsetX), (mouseY + winMouseOffsetY)
	}
		
	; Window updating enabled
	if (winEnabled) {
		DllCall("gdi32.dll\SetStretchBltMode", "uint", winDC, "int", 0)
		DllCall("gdi32.dll\StretchBlt", UInt, winDC, Int, 0, Int, 0, Int, (winWidth), Int, (winHeight), UInt, screenDC, UInt, (mouseX - ((winWidth / 2) / zoom)), UInt, (mouseY - ((winHeight / 2) / zoom)), Int, ((winWidth) / zoom), Int, (winHeight / zoom), UInt, 0xCC0020)
		
		; TODO [161217] - Make background transparent
		; TODO [161217] - Make x,y,h, and w adjustable
		; TODO [161217] - Take routine from get cursor ahk and update image based on current cursor image
		Gui, Add, Picture, x64 y64 h32 w32 AltSubmit BackgroundTrans, E:\home\travis\Documents\development\n0v1c3\windows\ahk\testCursor.bmp
	}
	
	; Sleep and repaint
	SetTimer Repaint, %winRepaintDelay%
Return

; Display tooltip with the current zoom level
ZoomTooltip:
	Tooltip, % "Zoom = " (zoom*100) "%"
	SetTimer, ZoomHideToolTip, 1000
Return

; Hide any tooltips
ZoomHideTooltip:
	Tooltip
Return

; ===
; Hotkeys
; ===

; Shift+Win+a
; Toggle window antialize
#+a::
	antialize := !antialize
	
	; TODO [161217] - Ensure that antialiasing can be toggled
	DllCall( "gdi32.dll\SetStretchBltMode", "uint", winDC, "int", 4*%antialize% )  ; Antializing ?
Return 

; Shift+Win+f
; Toggle window freeze (stop all movement and updates)
#+f::
	winFrozen := !winFrozen
Return

; Shift+Win+p
; Toggle window update (play/pause)
#+p::
	winEnabled := !winEnabled
Return

; Shift+Win+r
; Reload ahk script
#+r::
	Reload
Return

; Shift+Win+q
; Exit ahk script
#+q::
	; DC clean up
	;DllCall("gdi32.dll\DeleteDC", UInt, %winDC%)
	;DllCall("gdi32.dll\DeleteDC", UInt, %screenDC%)
	ExitApp
Return

; Shift+Win+Up
; Move window offset from cursor up
#+Up::
	winMouseOffsetY := winMouseOffsetY - GUI_WIN_MOUSE_OFFSET_ADJUST
Return

; Shift+Win+Down
; Move window offset from cursor up
#+Down::
	winMouseOffsetY := winMouseOffsetY + GUI_WIN_MOUSE_OFFSET_ADJUST
Return

; Shift+Win+Left
; Move window offset from cursor up
#+Left::
	winMouseOffsetX := winMouseOffsetX - GUI_WIN_MOUSE_OFFSET_ADJUST
Return

; Shift+Win+Right
; Move window offset from cursor up
#+Right::
	winMouseOffsetX := winMouseOffsetX + GUI_WIN_MOUSE_OFFSET_ADJUST
Return

; Shift+Win+WheelUp
; Zoom in
#+WheelUp::
	if (zoom < 20) {
		zoom := zoom + 1
	}
	
	Goto ZoomTooltip
Return

; Shift+Win+WheelDown
; Zoom out
#+WheelDown::
	if (zoom > 1) {
		zoom := zoom - 1
	}
	
	Goto ZoomTooltip
Return