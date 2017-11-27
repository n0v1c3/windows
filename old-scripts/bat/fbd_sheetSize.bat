::--------------------------------------------------
:: Variables
::--------------------------------------------------
set key="HKEY_CURRENT_USER\Software\Rockwell Software\RSLogix 5000\FBD Editor"
set value="Sheet Size"
set data=2

::--------------------------------------------------
:: "Force" Modification of Given Reg Value
::--------------------------------------------------
reg add %key% /t REG_DWORD /v %value% /d %data% /f