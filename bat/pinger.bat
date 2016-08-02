@echo off
setlocal enabledelayedexpansion

set OUTPUT_FILE=pinger-result.txt
>nul copy nul %OUTPUT_FILE%

ipconfig /all >>%OUTPUT_FILE%
route print >>%OUTPUT_FILE%

for /f %%i in (testservers.txt) do (
	set SERVER_ADDRESS=ADDRESS N/A
	set SERVER_STATE=DOWN
	for /f "tokens=1,2,3" %%x in ('ping -n 1 %%i ^&^& echo SERVER_IS_UP') do (
		if %%x==Reply (
			set SERVER_ADDRESS=%%z
			set SERVER_STATE=UP
		)
	)
	echo %%i [!SERVER_ADDRESS::=!] is !SERVER_STATE! >>%OUTPUT_FILE%
)