@ECHO OFF
TITLE PC Cleanup Utility v5 (Cleaner)
Color 08
cd \
cd /d "%systemdrive%"
cls
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
ECHO Please Double-Click On Cleaner Settings To Configure Your Settings.
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
del /f /s /q "%LocalAppData%\Microsoft\Windows\Temporary Internet Files\*.*" 2>NUL >NUL
FOR /D %%p IN ("%LocalAppData%\Microsoft\Windows\Temporary Internet Files\Content.IE5\*.*") DO rmdir "%%p" /s /q 2>NUL >NUL
FOR /D %%p IN ("%LocalAppData%\Microsoft\Windows\Temporary Internet Files\Low\Content.IE5\*.*") DO rmdir "%%p" /s /q 2>NUL >NUL
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
del /q "%LocalAppData%\Iconcache.db" /a 2>NUL >NUL
) ELSE (
IF EXIST "%windir%\system32\TweakUI.exe" GOTO TweakUI
del /q "%userprofile%\Local Settings\Application Data\Iconcache.db" /a 2>NUL >NUL
)
:TweakUI
:skip5
if %history% NEQ 1 GOTO skip6
:history
if exist %systemdrive%\Users (
del /f /s /q "%LocalAppData%\Microsoft\Windows\History\*.*" 2>NUL >NUL
) ELSE (
del /f /s /q "%userprofile%\Local Settings\History\*.*" 2>NUL >NUL
)
:skip6
if %thumbcache% NEQ 1 GOTO skip7
:ThumbCache
del /f /s /q /a %LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db 2>NUL >NUL
:skip7
if %DiskCleanup% NEQ 1 GOTO skip8
:DiskCleanup
cleanmgr /sagerun:98 >NUL
:skip8
if %firefox% NEQ 1 GOTO skip9
taskkill /f /im firefox.exe 2>NUL >NUL
set firefoxDataDir=%LocalAppData%\Mozilla\Firefox\Profiles
del /f /s /q "%firefoxDataDir%" 2>NUL >NUL
rd /s /q "%firefoxDataDir%" 2>NUL >NUL
for /d %%x in (%userprofile%\AppData\Roaming\Mozilla\Firefox\Profiles\*) do del /f /s /q %%x\*sqlite 2>NUL >NUL
:skip9
if %Chrome% NEQ 1 GOTO skip10
Taskkill /F /IM chrome.exe 2>NUL >NUL
set ChromeDir=%LocalAppData%\Google\Chrome\User Data
del /f /s /q "%ChromeDir%" 2>NUL >NUL
rd /s /q "%ChromeDir%" 2>NUL >NUL
:skip10
if %Opera% NEQ 1 GOTO skip11
taskkill /F /IM opera.exe 2>NUL >NUL
set OperaDataDir=%LocalAppData%\Opera\Opera
set OperaDataDir2=%userprofile%\AppData\Roaming\Opera\Opera
del /f /s /q "%OperaDataDir%" 2>NUL >NUL
rd /s /q "%OperaDataDir%" 2>NUL >NUL
del /f /s /q "%OperaDataDir2%" 2>NUL >NUL
rd /s /q "%OperaDataDir2%" 2>NUL >NUL
:skip11
if %SrubEI% NEQ 1 GOTO skip12
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255 2>NUL >NUL
:skip12
if %ClearClip% NEQ 1 GOTO skip13
ECHO >NUL | CLIP
:skip13
if %logfiles% NEQ 1 GOTO skip14
cd \ >NUL & cd /d "%windir%" >NUL
DEL *.log /S /F /Q 2>NUL >NUL
cd \ >NUL & cd /d "%systemdrive%" >NUL
for /f %%a in (Cleaner_Settings.sav) do set %%a
:skip14
if %run% NEQ 1 GOTO skip15
REG Delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /F 2>NUL >NUL
:skip15
if %Jumplist% NEQ 1 GOTO skip16
del /F /Q %APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\* 2>NUL >NUL
del /F /Q %APPDATA%\Microsoft\Windows\Recent\CustomDestinations\* 2>NUL >NUL
:skip16
GOTO Exit
:ERROR
CLS
ECHO ________________________________________________________________________________
ECHO Error!
ECHO ________________________________________________________________________________
ECHO.
ECHO There's A Problem With One Or More Of Your Environment Variables.
ECHO.
ECHO Press any key to abort . . .
PAUSE >nul
EXIT
:EXIT
::taskkill /f /im explorer.exe 2>NUL >NUL
::start explorer.exe 2>NUL >NUL
cd \ >NUL
cd /d "%TMP%" >NUL
echo MsgBox "Done!",64, "PC Cleanup Utility v5 (Cleaner)" > finish.vbs
cls
start finish.vbs
EXIT
