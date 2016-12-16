::Turn off echo
@Echo off

::Ensure C Drive is active
C:

::Title
Echo ====================================
Echo Travis' VirtualBox Headless Selector
Echo ====================================
Echo.

::Get all Virtual Machines in VirtualBox's default dir
setlocal enabledelayedexpansion
set Index=1
for /d %%D in ("%dir%%HOMEDRIVE%%HOMEPATH%\VirtualBox VMs\*") do (
  set "VBoxs[!Index!]=%%D"
  set /a Index+=1
)
set /a UBound=Index-1

::Calculate the length of the path upto the Virtual Machine folder
cd "C:\Users\Travis\VirtualBox VMs"
for /L %%n in (1 1 500) do if "!__cd__:~%%n,1!" neq "" set /a "len=%%n+1"

::Remove folder path and display Virtul Machine name
for /l %%i in (1,1,%UBound%) do ( 
	set "VBoxs[%%i]=!VBoxs[%%i]:~%len%!"
	echo %%i. !VBoxs[%%i]! 
)

::Ensure that Choice is within allowed parameters
:choiceloop
set /p Choice=Select Virtual Machine: 
if "%Choice%"=="" goto chioceloop
if %Choice% LSS 1 goto choiceloop
if %Choice% GTR %UBound% goto choiceloop

::Set VBox to selected Virtual Machine
set VBox=!VBoxs[%Choice%]!

::Display selected Virtual Machine and pause for a cancel
Echo.
Echo Virtual Box Selected: %VBox%
Echo Exit Now to Cancel
pause

::Change directory to have access to the VirtualBox commands
cd "C:\Program Files\Oracle\VirtualBox"

::Start selected VM in headless mode
VBoxManage startvm "%VBox%" --type headless
pause