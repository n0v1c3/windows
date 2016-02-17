# README.TXT

This project is a generic base for a HC12 ANSI-C projectdebugged with a Motorola SDI.

Project layout:
===============

Folders used:

- Sources: Will contain your sources. For the moment, it contains an empty 'main.c' as a base.
  -------
- Debugger Cmd Files: Here you can place your own specific debugger command files.
  ------------------
- Startup Code: Contains the startup code of the application. You may adapt it
  ------------  to your own needs, but in such a case make sure that you create a local copy.

- Prm: Contains the linker parameter file used for linking (.prm)
  ---  and a Batch Burner command file (usual extension is .bbl, see \docu\common\manual\Manual Burner.pdf )
       Note that the file used for the linker
       is specified in the Linker Preference Panel itself (<ALT-F7>

- Libs: Contains the ANSI library to be linked with.
  ----
- Debugger Project File: This .ini file is passed to the debugger/simulator
  ---------------------  as configuration file. It contains various target interface settings, and path
                         information as well. This file can also be edited from the simulator/debugger e.g. using
                         File->Configuration in the simulator/debugger.

- Debugger Cmd Files: these files contain commands to be played at specific stages of the process.
  ------------------
	-startup.cmd:  This command file is executed to set up the target system just 
				   after the connection has been established.
	-reset.cmd:    This command file is executed after a user enforce reset has been 
				   performed (the Reset button, menu entry or command line command has been used).
	-preload.cmd:  This command file is executed before an application (code or symbols) 
	               is loaded in the debugger.
	-postload.cmd: This command file is executed after an application (code or symbols) 
	               has been loaded in the debugger.
    -vppon.cmd:    This command file is executed before Non Volatile Memory is erased 
                   or programmed using the NVMC dialog or the corresponding debugger command.
    -vppoff.cmd:   The Vppoff command file is executed after Non Volatile Memory has
                   been erased or programmed using the NVMC dialog or the corresponding debugger command.

Build Targets:
==============

This project contains following build targets :
- Ram Application : Build settings are suitable for an application located in Ram.
- Flash Application : For code located in Flash.
- Banked Flash : For code located in banked Flash.


Compiler options: 
=================
The Compiler option -ol0 has been set up to disable some compiler optimizations
in order to be able to see all the local variables in the debugger Data component.


Hardware Notes:
===============
When starting the debugger, the derivative flash can be automatically
erased and the project application programmed to the onchip flash memory.

The onchip flash memory will be erased and written each time you 
perform a load. Please check "preload.cmd" and "postload.cmd" command files
execution to enable/disable this process. The execution of these command files
is monitored with the SDI | Command Files dialog.
