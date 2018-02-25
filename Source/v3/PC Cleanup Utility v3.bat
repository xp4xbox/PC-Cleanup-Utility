@ECHO OFF
TITLE PC Cleanup Utility v3
Color 2e & CLS
::**********************************************************************************************************************************************************************
::PLEASE READ :
::There is NO waranty of any kind on this file.
::Use common sense, Incorrect Environment Variables and or incorrect editing of this file may result in damage or loss of data.
::This file works on Windows XP, Windows Vista And Windows 7.
::All other apps should be closed before running this.

::This file uses environment variables to locate your "%systemdrive%", "%userprofile%" , %TEMP% , %TMP% and %windir%, please make sure they are properly set, 
::See below for more details.

::::::::::::Variable Info
::If the variable %systemdrive% does not point to your drive wich contains your windows folder, edit this file and replace those variables with the 
::drive that contains your windows folder such as C: (Make sure that you add a colon to the drive letter)
::If the variable %windir% does not point to your windows home directory, edit this file and replace %windir% with the full path to your windows home directory, 
::such as c:\windows. If the the variables %temp% and %tmp% do not point to your temp directories, edit this file and replace those variables with 
::the full path to your temp directories. If the variable %userprofile% does not point to your <username> directory, edit this file and replace those variables with 
::the full path to your <username>, such as C:\Users\billg or C:\Documents and Settings\billg.
::::::::::::Variable Info

::NOTE: To check your environmental variables, type "SET" without the quotation marks in cmd, it will display a list of your variables and there paths.

::If you are using Windows Vista or Windows 7, make sure that you have a folder in your %systemdrive% called Users, such as C:\Users. 
::If you don't have one, create a dummie one.
::Please make sure if you are using Windows XP, that you have NO "users", "Users" or "USERS" folder in the root of your system drive. Ex: C:\Users. 

::NOTE: It's very rare that this file needs to be modified to run right on your computer, but you may have incorrectly changed variables such as %userprofile%, 
::%TEMP% and %systemdrive%

::If you have any questions/concerns or find any bugs please send me a Private Message at http://www.instructables.com/member/xp4xbox/ or 
::email me at *****@gmail.com.

::**********************************************************************************************************************************************************************

ECHO  PC Cleanup Utility  Made By Nicolas Hawrysh, a Windows Cleanup Tool.
ECHO                                Version 3
ECHO  ---------------------------------------------------------------------
ECHO    Any Part Of This File May Be Reproduced And Redistributed As Long
ECHO                          As You Give Me Credit.
ECHO  ---------------------------------------------------------------------
ECHO        Use Notepad Or Edit To View File Contents Before Running!
ECHO          Only You Can Determine If The File Contents And
ECHO          Structure Are OK To Run On Your *Specific Setup*.
ECHO         See http://www.instructables.com/id/PC-Cleanup-Utility-v3/
ECHO          For Even More Information And For Newer Versions.
ECHO                              -------------                   
ECHO  This Batch File Aggressively Cleans Up Unnecessary Files On Your Computer.
ECHO  Note 1: All Other Apps Should Be Closed Before Running This.
ECHO  Note 2: This File Uses Environmental Variables To Locate Several Directories 
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
:Menu
mode 34,14
CLS
ECHO _________________________________
ECHO PC Cleanup Utility v3
ECHO _________________________________
ECHO X Exit
ECHO I Delete Temporary Internet Files
ECHO T Delete Temp Files
ECHO C Delete Internet Cookies
ECHO D Delete Icon Cache
ECHO R Delete Recent Documents
ECHO F Disk Defragmenter
ECHO M More Options
ECHO _________________________________
SET N=
SET /P N=Type Selection:
IF NOT DEFINED N (
GOTO Menu
) 
IF /I "%N%"=="x" GOTO Exit
IF /I "%N%"=="i" GOTO InternetFiles
IF /I "%N%"=="c" GOTO Cookies
IF /I "%N%"=="r" GOTO Recent
IF /I "%N%"=="t" GOTO Temp
IF /I "%N%"=="d" GOTO IconCache
IF /I "%N%"=="m" GOTO More
IF /I "%N%"=="f" GOTO Defrag
ECHO Invalid Choice, Please Try Again!
PAUSE >nul
GOTO Menu
:Exit
GOTO Thanks
:InternetFiles
GOTO InternetFilesScreen
:InternetFiles1
IF NOT EXIST %SystemDrive%\Users (
GOTO InternetFilesXP
) ELSE (
del /f /q "%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*" >NUL
del /f /q "%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\Low\*.*" >NUL
del /f /q "%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\Content.IE5\*.*" >NUL
del /f /q "%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\Low\Content.IE5\*.*" >NUL
FOR /D %%p IN ("%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\Content.IE5\*.*") DO rmdir "%%p" /s /q >NUL
FOR /D %%p IN ("%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\Low\Content.IE5\*.*") DO rmdir "%%p" /s /q >NUL
GOTO InternetFilesEnd
)
:InternetFilesXP
del /f /q "%userprofile%\Local Settings\Temporary Internet Files\*.*" >NUL
del /f /q "%userprofile%\Local Settings\Temporary Internet Files\Content.IE5\*.*" >NUL
FOR /D %%p IN ("%userprofile%\Local Settings\Temporary Internet Files\Content.IE5\*.*") DO rmdir "%%p" /s /q >NUL
GOTO InternetFilesEnd
:Cookies
GOTO CookiesScreen
:Cookies1
IF NOT EXIST %SystemDrive%\Users (
GOTO CookiesXP
)
del /f /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Cookies\*.*" >NUL
IF EXIST "%userprofile%\AppData\Roaming\Microsoft\Windows\Cookies\Low" (
del /f /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Cookies\Low\*.*" >NUL
)
GOTO CookiesEnd
:CookiesXP
del /f /q "%userprofile%\Cookies\*.*" >NUL
GOTO CookiesEnd
:Recent
GOTO RecentScreen
:Recent2
IF EXIST "%systemdrive%\Users" (
del /f /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Recent\*.*" >NUL
) ELSE (
del /f /q "%userprofile%\Recent\*.*" >NUL
)
GOTO RecentEnd
:More
cleanmgr /sageset:99 >NUL
cleanmgr /sagerun:99 >NUL
GOTO Menu
:Temp
GOTO TempScreen
:Temp2
del /f /q "%TEMP%\*.*" >NUL
del /f /q "%TMP%\*.*" >NUL
del /f /q "%windir%\Temp\*.*" >NUL
del /f /q "%systemdrive%\Temp\*.*" >NUL
FOR /D %%p IN ("%TEMP%\*.*") DO rmdir "%%p" /s /q >NUL
FOR /D %%p IN ("%TMP%\*.*") DO rmdir "%%p" /s /q >NUL
FOR /D %%p IN ("%windir%\Temp\*.*") DO rmdir "%%p" /s /q >NUL
FOR /D %%p IN ("%systemdrive%\Temp\*.*") DO rmdir "%%p" /s /q >NUL
set Vis7=%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\
if exist %Vis7%*.zip del /f /q %Vis7%*.zip                  
if exist %Vis7%*.exe del /f /q %Vis7%*.exe
if exist %Vis7%*.gif del /f /q %Vis7%*.gif
if exist %Vis7%*.jpg del /f /q %Vis7%*.jpg
if exist %Vis7%*.png del /f /q %Vis7%*.png
if exist %Vis7%*.bmp del /f /q %Vis7%*.bmp
if exist %Vis7%*.avi del /f /q %Vis7%*.avi
if exist %Vis7%*.mpg del /f /q %Vis7%*.mpg
if exist %Vis7%*.mpeg del /f /q %Vis7%*.mpeg
if exist %Vis7%*.ra  del /f /q %Vis7%*.ra
if exist %Vis7%*.ram del /f /q %Vis7%*.ram
if exist %Vis7%*.mp3 del /f /q %Vis7%*.mp3
if exist %Vis7%*.mov del /f /q %Vis7%*.mov
if exist %Vis7%*.qt del /f /q %Vis7%*.qt
if exist %Vis7%*.asf del /f /q %Vis7%*.asf
set XP=%userprofile%\Local Settings\Temporary Internet Files\
if exist %XP%*.zip del /f /q %XP%*.zip
if exist %XP%*.exe del /f /q %XP%*.exe
if exist %XP%*.gif del /f /q %XP%*.gif
if exist %XP%*.jpg del /f /q %XP%*.jpg
if exist %XP%*.png del /f /q %XP%*.png
if exist %XP%*.bmp del /f /q %XP%*.bmp
if exist %XP%*.avi del /f /q %XP%*.avi
if exist %XP%*.mpg del /f /q %XP%*.mpg
if exist %XP%*.mpeg del /f /q %XP%*.mpeg
if exist %XP%*.ra  del /f /q %XP%*.ra
if exist %XP%*.ram del /f /q %XP%*.ram
if exist %XP%*.mp3 del /f /q %XP%*.mp3
if exist %XP%*.mov del /f /q %XP%*.mov
if exist %XP%*.qt del /f /q %XP%*.qt
if exist %XP%*.asf del /f /q %XP%*.asf
GOTO TempEnd
:IconCache
GOTO IconCacheScreen
:IconCache2
IF EXIST %systemdrive%\Users (
del /q "%userprofile%\AppData\Local\Iconcache.db" /a >NUL
) ELSE (
IF EXIST "%systemdrive%\WINDOWS\system32\TweakUI.exe" GOTO TweakUI
del /q "%userprofile%\Local Settings\Application Data\Iconcache.db" /a >NUL
)
:TweakUI
GOTO IconCacheEnd
::***********************************************************************************************************************
:Defrag
mode 50, 20
IF EXIST %SystemDrive%\Users GOTO DefragVista7
CLS
ECHO _________________________________________________
ECHO Disk Defragmenter
ECHO _________________________________________________
ECHO.
ECHO Please Type Your Drive Letter Of The 
ECHO.
ECHO Drive You Wish to Defrag : 
ECHO.
ECHO.
set /p defrag1=
IF EXIST %defrag1%:\ (
ECHO.
ECHO.
Defrag %defrag1%:
GOTO Menu
) ELSE (
ECHO.
ECHO.
ECHO Invalid Drive, Please Try Again!
PAUSE >nul
GOTO Defrag
)
:DefragVista7
CLS
ECHO _________________________________________________
ECHO Disk Defragmenter
ECHO _________________________________________________
ECHO.
ECHO Please Type Your Drive Letter Of The 
ECHO.
ECHO Drive You Wish to Defrag Or Type "All" to Defrag all Volumes :
ECHO.
ECHO.
set /p DefragVista7=
IF /I "%DefragVista7%"=="All" GOTO DefragVista7All
IF EXIST %DefragVista7%:\ (
ECHO.
ECHO.
Defrag %DefragVista7%:
GOTO Menu
) ELSE (
ECHO.
ECHO.
ECHO Invalid Drive, Please Try Again!
PAUSE >nul
GOTO DefragVista7
)
:DefragVista7All
Defrag -c
GOTO Menu

::***********************************************************************************************************************
:IconCacheScreen
mode 68 ,25
CLS
ECHO ___________________________________________________________________
ECHO Delete Icon Cache
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Icon Cache, Please Wait
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Icon Cache
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Icon Cache, Please Wait .
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Icon Cache
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Icon Cache, Please Wait . .
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Icon Cache
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Icon Cache, Please Wait . . .
ping -n 1 127.0.0.1 >nul
GOTO IconCache2
:RecentScreen
mode 68 ,25
CLS
ECHO ___________________________________________________________________
ECHO Delete Recent Documents
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Recent Documents, Please Wait
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Recent Documents
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Recent Documents, Please Wait .
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Recent Documents
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Recent Documents, Please Wait . .
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Recent Documents
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Recent Documents, Please Wait . . .
ping -n 1 127.0.0.1 >nul
GOTO Recent2
:CookiesScreen
mode 68 ,25
CLS
ECHO ___________________________________________________________________
ECHO Delete Internet Cookies
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Internet Cookies, Please Wait
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Internet Cookies
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Internet Cookies, Please Wait .
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Internet Cookies
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Internet Cookies, Please Wait . .
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Internet Cookies
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Internet Cookies, Please Wait . . .
ping -n 1 127.0.0.1 >nul
GOTO Cookies1
:TempScreen
mode 68 ,25
CLS
ECHO ___________________________________________________________________
ECHO Delete Temp Files
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Temp Files, Please Wait
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Temp Files
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Temp Files, Please Wait .
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Temp Files
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Temp Files, Please Wait . .
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Temp Files
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Temp Files, Please Wait . . .
ping -n 1 127.0.0.1 >nul
GOTO Temp2
:InternetFilesScreen
mode 68 ,25
CLS
ECHO ___________________________________________________________________
ECHO Delete Temporary Internet Files
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Temporary Internet Files, Please Wait
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Temporary Internet Files
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Temporary Internet Files, Please Wait .
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Temporary Internet Files
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Temporary Internet Files, Please Wait . .
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Temporary Internet Files
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Temporary Internet Files, Please Wait . . .
ping -n 1 127.0.0.1 >nul
GOTO InternetFiles1
::***********************************************************************************************************************
:InternetFilesEnd
CLS
ECHO ___________________________________________________________________
ECHO Delete Temporary Internet Files
ECHO ___________________________________________________________________
ECHO.
ECHO Temporary Internet Files Have Been Deleted.
pause >nul
GOTO Menu
:CookiesEnd
CLS
ECHO ___________________________________________________________________
ECHO Delete Internet Cookies
ECHO ___________________________________________________________________
ECHO.
ECHO Internet Cookies Have Been Deleted.
pause >nul
GOTO Menu
:RecentEnd
CLS
ECHO ___________________________________________________________________
ECHO Delete Recent Documents
ECHO ___________________________________________________________________
ECHO.
ECHO Recent Documents Have Been Deleted.
pause >nul
GOTO Menu
:TempEnd
CLS
ECHO ___________________________________________________________________
ECHO Delete Temp Files
ECHO ___________________________________________________________________
ECHO.
ECHO Temp Files Have Been Deleted.
pause >nul
GOTO Menu
:IconCacheEnd
CLS
ECHO ___________________________________________________________________
ECHO Delete Icon Cache
ECHO ___________________________________________________________________
ECHO.
ECHO Icon Cache Has Been Deleted.
pause >nul
GOTO Menu
:Thanks
mode 80, 25
CLS
ECHO ________________________________________________________________________________
ECHO           ------------------------------------------------------------
ECHO           Thank You For Using PC Cleanup Utility v3 By Nicolas Hawrysh
ECHO           ------------------------------------------------------------
ECHO.
ECHO.
ECHO                          -----------------------------
ECHO                          For Best Results, Reboot Now.
ECHO                          -----------------------------
ping -n 3 127.0.0.1 >nul
EXIT
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
::***********************************************************************************************************************
