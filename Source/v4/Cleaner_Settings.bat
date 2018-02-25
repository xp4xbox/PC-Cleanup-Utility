@ECHO OFF
TITLE PC Cleanup Utility v4 (Cleaner)
Color 08
cd \
cd /d "%systemdrive%"
cls
GOTO check
cls
ECHO   PC Cleanup Utility Made By Nicolas Hawrysh, a Windows Cleanup Tool.
ECHO                           Version 4 (Cleaner)                          
ECHO  ---------------------------------------------------------------------
ECHO    Any Part Of This File May Be Reproduced And Redistributed As Long
ECHO                          As You Give Me Credit.
ECHO  ---------------------------------------------------------------------
ECHO        Use Notepad Or Edit To View File Contents Before Running!
ECHO            Only You Can Determine If The File Contents And
ECHO          Structure Are OK To Run On Your *Specific Setup*. But
ECHO         This File Will Work Fine As-Is On Standard Windows Setups
ECHO         See http://www.instructables.com/id/PC-Cleanup-Utility-v3/
ECHO             For Even More Information And For Newer Versions.
ECHO                              -------------                   
ECHO  This Batch File Aggressively Cleans Up Unnecessary Files On Your Computer.
ECHO  Note 1: You Will Need To Right-Click And Run As Administrator For 
ECHO  Several Options And To Allow You To Delete Certain Files
ECHO  Note 2: All Other Apps Should Be Closed Before Running This.
ECHO  Note 3: This File Uses Environmental Variables To Locate Several Directories 
ECHO  Including Your Windows Home Directory, Your Temp Directory And More.
ECHO  *Read This File* In Notepad Or Edit For More Information.
ECHO  ---------------------------------------------------------------------
ECHO If You Haven't Followed The Instructions Above, Hit Ctrl-C To Abort; Otherwise
pause
:check
IF "%windir%" == "" GOTO ERROR
IF "%systemdrive%" == "" GOTO ERROR
IF "%userprofile%" == "" GOTO ERROR
IF "%TEMP%" == "" GOTO ERROR
IF "%TMP%" == "" GOTO ERROR
IF NOT EXIST Cleaner_Settings.sav (
CLS
ECHO You Have Not Configured Any Settings Yet.
ECHO.
ECHO Please Double-Click On Cleaner Settings.bat To Configure Your Settings.
ECHO.
ECHO Press any key to abort . . . 
PAUSE >NUL
EXIT
)
cls
for /f %%a in (Cleaner_Settings.sav) do set %%a
IF %internetfiles% NEQ 1 GOTO skip
IF NOT EXIST %SystemDrive%\Users (
GOTO InternetFilesXP
) ELSE (
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*" 2>NUL >NUL
FOR /D %%p IN ("%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\Content.IE5\*.*") DO rmdir "%%p" /s /q 2>NUL >NUL
FOR /D %%p IN ("%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\Low\Content.IE5\*.*") DO rmdir "%%p" /s /q 2>NUL >NUL
GOTO skip
)
:InternetFilesXP
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*" 2>NUL >NUL
FOR /D %%p IN ("%userprofile%\Local Settings\Temporary Internet Files\Content.IE5\*.*") DO rmdir "%%p" /s /q 2>NUL >NUL
:skip
IF %cookies% NEQ 1 GOTO skip2
IF NOT EXIST %SystemDrive%\Users (
GOTO CookiesXP
)
del /f /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Cookies\*.*" 2>NUL >NUL
IF EXIST "%userprofile%\AppData\Roaming\Microsoft\Windows\Cookies\Low" (
del /f /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Cookies\Low\*.*" 2>NUL >NUL
GOTO skip2
)
:CookiesXP
del /f /q "%userprofile%\Cookies\*.*" 2>NUL >NUL
:skip2
IF %recent% NEQ 1 GOTO skip3
IF EXIST "%systemdrive%\Users" (
del /f /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Recent\*.*" 2>NUL >NUL
) ELSE (
del /f /q "%userprofile%\Recent\*.*" 2>NUL >NUL
)
:skip3
IF %temp% NEQ 1 GOTO skip4
del /f /q "%TEMP%\*.*" 2>NUL >NUL
del /f /q "%TMP%\*.*" 2>NUL >NUL
del /f /q "%windir%\Temp\*.*" 2>NUL >NUL
if exist "%systemdrive%\Temp" (
del /f /q "%systemdrive%\Temp\*.*" 2>NUL >NUL
FOR /D %%p IN ("%systemdrive%\Temp\*.*") DO rmdir "%%p" /s /q 2>NUL >NUL
)
FOR /D %%p IN ("%TEMP%\*.*") DO rmdir "%%p" /s /q 2>NUL >NUL
FOR /D %%p IN ("%TMP%\*.*") DO rmdir "%%p" /s /q 2>NUL >NUL
FOR /D %%p IN ("%windir%\Temp\*.*") DO rmdir "%%p" /s /q 2>NUL >NUL
:skip4
IF %iconcache% NEQ 1 GOTO skip5
:IconCache
IF EXIST %systemdrive%\Users (
del /q "%userprofile%\AppData\Local\Iconcache.db" /a 2>NUL >NUL
) ELSE (
IF EXIST "%windir%\system32\TweakUI.exe" GOTO TweakUI
del /q "%userprofile%\Local Settings\Application Data\Iconcache.db" /a 2>NUL >NUL
)
taskkill /f /im explorer.exe 2>NUL >NUL
start explorer.exe 2>NUL >NUL
:TweakUI
:skip5
if %history% NEQ 1 GOTO skip6
:history
if exist %systemdrive%\Users (
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\History\*.*" 2>NUL >NUL
) ELSE (
del /f /s /q "%userprofile%\Local Settings\History\*.*" 2>NUL >NUL
)
:skip6
if %thumbcache% NEQ 1 GOTO skip7
:ThumbCache
if exist "%systemdrive%\Users" (
taskkill /f /im explorer.exe 2>NUL >NUL
del /f /s /q /a %LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db 2>NUL >NUL
start explorer.exe 2>NUL >NUL
)
:skip7
if %DiskCleanup% NEQ 1 GOTO skip8
:DiskCleanup
cleanmgr /sagerun:98 >NUL
:skip8
GOTO Exit
:ERROR
CLS
ECHO ________________________________________________________________________________
ECHO Error!
ECHO ________________________________________________________________________________
ECHO.
ECHO There's A Problem With One Or More Of Your Environment Variables.
ECHO Please Edit This File Manually To Insert The Correct Path{s}
ECHO To The Referenced Directories.
ECHO.
ECHO Press any key to abort . . .
PAUSE >nul
EXIT
:EXIT
cd \ >NUL
cd "%TMP%" >NUL
echo MsgBox "Done!",64, "PC Cleanup Utility v4 (Cleaner)" > finish.vbs
cls
start finish.vbs
EXIT
