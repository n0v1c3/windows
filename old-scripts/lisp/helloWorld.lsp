;----------

;  Author: Travis Gall
; Company: Travis Corp.
;   Email: travis.gall@gmail.com
;    Date: May 15, 2013
;
; Print "Hello World" followed by a line break into the console
; - Define function HelloWorld to display "Hello World" followed by a line break
; - Call Function HelloWorld
; - Sleep

;----------

; Function: helloWorld
; Parameters: <none>
;
; Print "Hello World" to the console followed by a line break

(defun helloWorld ();Define HelloWorld function
	(format t "Hello World~%");Print "Hello World" to console folowed by a line break
);defun HelloWorld

;----------

; Program: Main
;
; Display "Hello World" in the console and sleep for .75 seconds

(progn
	(helloWorld);Call HelloWorld function
	(sleep 1.0);Maintain command window to see message (seconds)
);progn Main

;----------