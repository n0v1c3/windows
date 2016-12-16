@echo OFF
setlocal ENABLEEXTENSIONS

Echo =====================================
Echo Travis' Run Command Modification Tool
Echo =====================================
Echo.

::Default Run Command Directory
set KEY_NAME="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths"
set VALUE_NAME=Path

::Get Command to be Added from the User
set /p NewCommand=Enter the New Command:
set /p NewCommandPath=Enter the Path to the Command:

::Get Name and Data Type of Registry Entry
FOR /F "tokens=1-2" %%A IN ('REG QUERY %KEY_NAME% /v %VALUE_NAME% 2^>nul') DO (
    set ValueName=%%A
    set ValueType=%%B
)

::Get Value of Registry Entry
FOR /F "usebackq tokens=3*" %%A IN (`REG QUERY %KEY_NAME% /v %VALUE_NAME%`) DO (
    set ValueValue=%%A %%B
)

::Display Results
if defined ValueName (
    @echo Value Name = %ValueName%
    @echo Value Type = %ValueType%
    @echo Value Value = %ValueValue%
) else (
    @echo %KEY_NAME%\%VALUE_NAME% not found.
)

::Pause and End Program
pause