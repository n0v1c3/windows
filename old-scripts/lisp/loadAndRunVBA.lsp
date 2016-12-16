;----------

;  Author: Travis Gall
; Company: Travis Corp.
;   Email: travis.gall@gmail.com
;    Date: May 15, 2013
;
; Load selected VBA project into the current AutoCAD application and run desired subroutine
; - Define function c:loadAndRunVBA(ProjName MacroName) - load project and run macro defined in function call
; - Call Function c:loadAndRunVBA with desired VBA project and macro

;----------

;   Function: c:loadAndRunVBA
; Parameters: ProjName [String] - VBA project to be loaded (full path and name) 
;             MacroName [String] - VBA subroutine to run
;
; Load VBA project and run macro defined in function call
; - Ensure file exists
; - Load VBA Project into the VBA Manager
; - Run VBA Macro from active AutoCAD application

(defun c:loadAndRunVBA (ProjName MacroName);Define loadAndRunVBA
	(if (findfile ProjName);Ensure file exists
		;File exists
		(progn
			(vl-vbaload ProjName);Load project into VBA Manager
			(vl-vbarun MacroName);Run VBA macro
		);progn
		
		;else
	);if (findfile ProjName)
);defun

;----------

; Program: Main
;
; Call loadAndRunVBA to desired VBA script

(progn
	(c:loadAndRunVBA ("C:\\Test.dvb" "Test"));Call loadAndRunVBA to desired VBA script
);progn