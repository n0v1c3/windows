@Echo Off
Setlocal
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: _FTPServer   The ip address or url for the FTP Server
:: _Username    The User name to log into the FTP Server
:: _Password    The passsword for the FTP Account. This is readable by anyone
:: _FTPFolder   The folder to use on the FTP Server
:: _FileSource1 The path and first file mask for the files that you want to upload
:: _FileSource2 The path and Second file mask for the files that you want to upload
:: _FTPScript   The path\name of a temp file to use for the FTP Script. Default is
::              FTPScript.txt in the current user's temp folder. It is created
::              on the fly, and deleted when finished unless there is an error.
Set _FTPServer=upload.comcast.net
Set _Username=username
Set _Password=password
Set _FTPFolder=Backups
Set _FileSource1=C:\Temp Dir\Test\*.txt
Set _FileSource2=C:\Temp Dir\Test\*.doc
Set _FileBackup=I:\Backup
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Create FTP Script. Login, change local directory, make remote directory
:: Change to that directory, then switch mode to Binary
Set _FTPScript=%Temp%\FTPScript.txt
Set _FTPTemplist=%Temp%\FTPTempList.txt
Set _FTPFilelist=%Temp%\FTPFileList.txt
(Echo.open %_FTPServer%
Echo.%_Username%
Echo.%_Password%
Echo.lcd "%_FileSource1%"
Echo.mkdir "%_FTPFolder%"
Echo.cd "%_FTPFolder%"
Echo.binary
)>"%_FTPScript%" 
:: Now need to create a list of files to upload.
:: Run Xcopy against the Backup folder with the /L switch
:: If using the /S or /E Switches, there MUST NOT be any
:: duplicate files names even in different folders. If there are
:: only the last one will actuallbe stored on the FTP Server.
Echo Generating list of files, please wait
Set _Flag1=0
>"%_FTPTemplist%" XCopy /CDE /L "%_FileSource1%" "%_FileBackup%\"
For /F "Tokens=3 Delims=:" %%I In ('Find /C /I /V "file(s)" "%_FTPTemplist%"') Do If "%%I"==" 0" Set _Flag1=1&Goto _Next1
>"%_FTPFilelist%" Find /I /V "file(s)" "%_FTPTemplist%"
:: Add them to the FTP Script.
For /F "Tokens=* skip=2" %%I In ('Type "%_FTPFilelist%"') Do Echo put "%%I">>"%_FTPScript%"
:_Next1
:: Get next set of files`
Set _Flag2=0
>"%_FTPTemplist%" XCopy /CDE /L "%_FileSource2%" "%_FileBackup%\"
For /F "Tokens=3 Delims=:" %%I In ('Find /C /I /V "file(s)" "%_FTPTemplist%"') Do If "%%I"==" 0" Set _Flag2=1&Goto _Chk1
>"%_FTPFilelist%" Find /I /V "file(s)" "%_FTPTemplist%"
:: Now add them to the FTP Script.
For /F "Tokens=* skip=2" %%I In ('Type "%_FTPFilelist%"') Do Echo put "%%I">>"%_FTPScript%"
:_Chk1
Set /A _Flag=_Flag1+_Flag2
If %_Flag%==2 Echo No Files to Copy&Goto _Cleanup
:: now add quit command
>>"%_FTPScript%" Echo.quit
:: Script is created, now run the script
:: To open the script and file lists In Notepad for testing, uncomment the next four lines. 
:: Start "" Notepad "%_FTPScript%"
:: Start "" Notepad "%_FTPTemplist%"
:: Start "" Notepad "%_FTPFilelist%"
:: Goto :EOF
Echo Uploading files, please wait
Ftp -v -s:"%_FTPScript%"
If Not ERRORLEVEL 1 Goto _FTPDone
Echo.There was an FTP Error of %ERRORLEVEL%
Echo.The script file will not be deleted.
Echo.The local Backup has not been done.
Echo.Location of files:
Echo.FTP Script    - "%_FTPScript%"
Echo.FTP Temp List - "%_FTPTemplist%"
Echo.FTP File Lisr - "%_FTPFilelist%"
Pause
Goto :EOF
:_FTPDone
:: now do Local Backup
Echo. FTP Was successful, updating local backup, please wait.
XCopy /CDE "%_FileSource1%" "%_FileBackup%\"
XCopy /CDE "%_FileSource2%" "%_FileBackup%\"
:_Cleanup
:: Delete the temp files used
For %%I In ("%_FTPScript%","%_FTPTemplist%","%_FTPFilelist%") Do If Exist "%%I" Del /F /Q "%%I"
Goto :EOF