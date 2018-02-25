@ECHO OFF
TITLE PC Cleanup Utility v4
Color 2e & CLS
cd \ >NUL
cd /d "%systemdrive%" >NUL
::**********************************************************************************************************************************************************************
::PLEASE READ :
::There is NO waranty of any kind on these files.

::This file may be redistributed as long as you include this info in the file: 
::Copyright (c) 2015 Nicolas Hawrysh
::All Rights Reserved

::Use common sense, Incorrect Environment Variables and or incorrect editing of this file may result in damage or loss of data.
::These files has been tested and work on Windows XP, Windows Vista And Windows 7.
::All other apps should be closed before running this.

::For the PC Cleanup Utility and the Cleaner Settings, you must right-click and run as administrator unless you are using Windows XP, then just
::make sure that you are running it on a administrator account.

::You do not need to run the cleaner as an administrator, all options in the cleaner that are on the PC Cleanup Utility work fine without running as an administrator

::These files use environment variables to locate your "%systemdrive%", "%LocalAppData%" (For Vista And Higher), "%userprofile%" , %TEMP% , %TMP% and %windir%, 
::please make sure they are properly set, See below for more details.

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

::NOTE: It's very rare that these files need to be modified to run right on your computer, but you may have incorrectly changed variables such as %userprofile%, 
::%TEMP% and %systemdrive%

::If you have any questions/concerns or find any bugs please send me a Private Message at http://www.instructables.com/member/xp4xbox/ or 
::email me at *******@gmail.com.

::**********************************************************************************************************************************************************************
cls
ECHO   PC Cleanup Utility Made By Nicolas Hawrysh, a Windows Cleanup Tool.
ECHO                                Version 4
ECHO  ---------------------------------------------------------------------
ECHO                   Copyright (c) Nicolas Hawrysh 2015    
ECHO                          All Rights Reserved  
ECHO  ---------------------------------------------------------------------
ECHO        Use Notepad Or Edit To View File Contents Before Running!
ECHO            Only You Can Determine If The File Contents And
ECHO          Structure Are OK To Run On Your *Specific Setup*. But
ECHO         This File Will Work Fine As-Is On Standard Windows Setups
ECHO         See http://www.instructables.com/id/PC-Cleanup-Utility-v3/
ECHO             For Even More Information And For Newer Versions.
ECHO                              -------------                   
ECHO  This Batch File Aggressively Cleans Up Unnecessary Files On Your Computer.
ECHO  Note 1: You Will Need To Right-Click And Run As Administrator.
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
:Menu
cd \ >NUL
cd /d "%systemdrive%" >NUL
mode 34,20
CLS
ECHO _________________________________
ECHO PC Cleanup Utility v4
ECHO _________________________________
ECHO X Exit
ECHO I Delete Temporary Internet Files
ECHO H Delete History
ECHO C Delete Internet Cookies
ECHO T Delete Temp Files
ECHO D Delete Icon Cache
ECHO U Delete Thumbnail Cache & ::If you are using Windows XP, feel free to delete this line.
ECHO B Delete Thumbs.db
ECHO R Delete Recent Documents
ECHO E Empty Recycle Bin
ECHO F Disk Defragmenter
ECHO P Permenant File Deletion
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
IF /I "%N%"=="h" GOTO History
IF /I "%N%"=="u" GOTO ThumbCacheCheck
IF /I "%N%"=="b" GOTO Thumbsdb
IF /I "%N%"=="p" GOTO PermenantFile
IF /I "%N%"=="e" GOTO EmptyRecycle
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
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*" 2>NUL >NUL
FOR /D %%p IN ("%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\Content.IE5\*.*") DO rmdir "%%p" /s /q 2>NUL >NUL
FOR /D %%p IN ("%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\Low\Content.IE5\*.*") DO rmdir "%%p" /s /q 2>NUL >NUL
GOTO InternetFilesEnd
)
:InternetFilesXP
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*" 2>NUL >NUL
FOR /D %%p IN ("%userprofile%\Local Settings\Temporary Internet Files\Content.IE5\*.*") DO rmdir "%%p" /s /q 2>NUL >NUL
GOTO InternetFilesEnd
:Cookies
GOTO CookiesScreen
:Cookies1
IF NOT EXIST %SystemDrive%\Users (
GOTO CookiesXP
)
del /f /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Cookies\*.*" 2>NUL >NUL
IF EXIST "%userprofile%\AppData\Roaming\Microsoft\Windows\Cookies\Low" (
del /f /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Cookies\Low\*.*" 2>NUL >NUL
)
GOTO CookiesEnd
:CookiesXP
del /f /q "%userprofile%\Cookies\*.*" 2>NUL >NUL
GOTO CookiesEnd
:Recent
GOTO RecentScreen
:Recent2
IF EXIST "%systemdrive%\Users" (
del /f /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Recent\*.*" 2>NUL >NUL
) ELSE (
del /f /q "%userprofile%\Recent\*.*" 2>NUL >NUL
)
GOTO RecentEnd
:More
cleanmgr /sageset:99 >NUL
cleanmgr /sagerun:99 >NUL
GOTO Menu
:Temp
GOTO TempScreen
:Temp2
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
GOTO TempEnd
:IconCache
GOTO IconCacheScreen
:IconCache2
IF EXIST %systemdrive%\Users (
taskkill /f /im explorer.exe 2>NUL >NUL
del /q "%userprofile%\AppData\Local\Iconcache.db" /a 2>NUL >NUL
) ELSE (
IF EXIST "%windir%\system32\TweakUI.exe" GOTO TweakUI
taskkill /f /im explorer.exe 2>NUL >NUL
del /q "%userprofile%\Local Settings\Application Data\Iconcache.db" /a 2>NUL >NUL
)
start explorer.exe 2>NUL >NUL
:TweakUI
GOTO IconCacheEnd
:History
GOTO HistoryScreen
:History2
IF EXIST "%systemdrive%\Users" (
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\History\*.*" 2>NUL >NUL
) else (
del /f /s /q "%userprofile%\Local Settings\History\*.*" 2>NUL >NUL
)
GOTO HistoryEnd
:ThumbCacheCheck
if exist "%systemdrive%\Users" GOTO ThumbCache
cd \ >NUL
cd "%TMP%" >NUL
echo Msgbox "This Option Does Not Work On Windows XP" ,16 , "Error" > Error.vbs
start Error.vbs
GOTO Menu
:ThumbCache
GOTO ThumbScreen
:ThumbCache2
if exist "%systemdrive%\Users" (
taskkill /f /im explorer.exe 2>NUL >NUL
del /f /s /q /a "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" 2>NUL >NUL
start explorer.exe 2>NUL >NUL
)
GOTO ThumbCacheEnd
:Thumbsdb
GOTO ThumbsdbScreen
:Thumbsdb2 
cd \ >NUL
cd "%systemdrive%" >NUL
del /p /f /s /a Thumbs.db
if exist "d:\" (
cd \ >NUL
cd /d "d:\" 2>NUL >NUL
del /p /f /s /a Thumbs.db
)
if %systemdrive%==f: GOTO thumbsskip
if exist "f:\" (
cd \ >NUL
cd /d "f:\" 2>NUL >NUL
del /p /f /s /a Thumbs.db
)
:thumbsskip
cd \ >NUL
cd /d "%systemdrive%" >NUL
GOTO ThumbsdbEnd
::***********************************************************************************************************************
:EmptyRecycle
mode 75 ,25
cls
ECHO __________________________________________________________________________
ECHO Empty Recycle Bin
ECHO __________________________________________________________________________
ECHO.
ECHO WARNING: This Will Empty The Recycle Bin For Every User On This Computer.
ECHO.
ECHO Are You Sure You Want To Preform This Action? (Y/N)
ECHO.
set recycle=
set /p recycle=
IF NOT DEFINED recycle (
GOTO EmptyRecycle
) 
IF /I "%recycle%"=="n" GOTO Menu
IF /I "%recycle%"=="y" GOTO YesEmptyRecycle
ECHO Invalid Choice, Please Try Again!
PAUSE >nul
GOTO EmptyRecycle
:YesEmptyRecycle
if exist "%systemdrive%\recycler" (
rd /s /q "%systemdrive%\recycler" 2>NUL >NUL
GOTO Menu
)
if exist "%systemdrive%\$Recycle.Bin" (
rd /s /q "%systemdrive%\$Recycle.Bin" 2>NUL >NUL
GOTO Menu
) else (
cd \ >NUL
cd "%TMP%" >NUL
echo Msgbox "Recycle Bin Has Already Been Emptied" ,16 , "Error" > Error.vbs
start Error.vbs
GOTO Menu
)
:PermenantFile
mode 68 ,27
CLS
ECHO ___________________________________________________________________
ECHO Permenant File Deletion
ECHO ___________________________________________________________________ 
ECHO.
ECHO Please Enter The File Paths Of The Files That You Wish To Delete And
ECHO.
ECHO Then Type YES To Confirm That You Want To Delete Those(s) File(s) :
ECHO.
ECHO.
set file1=
set /p file1=
if not defined file1 GOTO PermenantFile
IF /I %file1%==YES ECHO. & ECHO You Have Not Selected Any Files Yet! & PAUSE >NUL & GOTO PermenantFile
if not exist %file1% ECHO. & ECHO That File Path Is Incorrect, Please Try Again! & PAUSE >NUL & GOTO PermenantFile
ECHO.
set file2=
set /p file2=
if not defined file2 GOTO PermenantFile
IF /I %file2%==YES (
FOR /L %%G in (1,1,7) DO TYPE NUL > %file1%
del /f /q /a %file1% 2>NUL >NUL
GOTO Menu
)
if not exist %file2% ECHO. & ECHO That File Path Is Incorrect, Please Try Again! & PAUSE >NUL & GOTO PermenantFile
ECHO.
set file3=
set /p file3=
if not defined file3 GOTO PermenantFile
IF /I %file3%==YES (
FOR /L %%G in (1,1,7) DO TYPE NUL > %file2% & TYPE NUL > %file1%
del /f /q /a %file2% 2>NUL >NUL
del /f /q /a %file1% 2>NUL >NUL
GOTO Menu
)
if not exist %file3% ECHO. & ECHO That File Path Is Incorrect, Please Try Again! & PAUSE >NUL & GOTO PermenantFile
ECHO.
set file4=
set /p file4=
if not defined file4 GOTO PermenantFile
IF /I %file4%==YES (
FOR /L %%G in (1,1,7) DO TYPE NUL > %file2% & TYPE NUL > %file3% & TYPE NUL > %file1%
del /f /q /a %file2% 2>NUL >NUL
del /f /q /a %file3% 2>NUL >NUL
del /f /q /a %file1% 2>NUL >NUL
GOTO Menu
)
if not exist %file4% ECHO. & ECHO That File Path Is Incorrect, Please Try Again! & PAUSE >NUL & GOTO PermenantFile
ECHO.
set file5=
set /p file5=
if not defined file5 GOTO PermenantFile
IF /I %file5%==YES (
FOR /L %%G in (1,1,7) DO TYPE NUL > %file2% & TYPE NUL > %file3% & TYPE NUL > %file4% & TYPE NUL > %file1%
del /f /q /a %file2% 2>NUL >NUL
del /f /q /a %file3% 2>NUL >NUL
del /f /q /a %file1% 2>NUL >NUL
del /f /q /a %file4% 2>NUL >NUL
GOTO Menu
)
if not exist %file5% ECHO. & ECHO That File Path Is Incorrect, Please Try Again! & PAUSE >NUL & GOTO PermenantFile
ECHO.
ECHO Sorry, You Cannot Delete More Than 4 Files At a Time. & PAUSE >NUL & GOTO PermenantFile
::***********************************************************************************************************************
:Defrag
IF EXIST %SystemDrive%\Users GOTO DefragVista7
mode 50,20
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
Defrag %defrag1%: -f -v
GOTO Menu
) ELSE (
ECHO.
ECHO.
ECHO Invalid Drive, Please Try Again!
PAUSE >nul
GOTO Defrag
)
:DefragVista7
mode 50,22
CLS
ECHO _________________________________________________
ECHO Disk Defragmenter
ECHO _________________________________________________
ECHO.
ECHO Please Type Your Drive Letter Of The 
ECHO.
ECHO Drive You Wish to Defrag Or Type "All" 
ECHO.
ECHO To Defrag All Volumes :
ECHO.
ECHO.
set /p DefragVista7=
IF /I "%DefragVista7%"=="All" GOTO DefragVista7All
IF EXIST %DefragVista7%:\ (
ECHO.
ECHO.
Defrag %DefragVista7%: -v
GOTO Menu
) ELSE (
ECHO.
ECHO.
ECHO Invalid Drive, Please Try Again!
PAUSE >nul
GOTO DefragVista7
)
:DefragVista7All
Defrag -c -v
GOTO Menu

::***********************************************************************************************************************

:ThumbsdbScreen
mode 68 ,25
CLS
ECHO ___________________________________________________________________
ECHO Delete Thumbs.db
ECHO ___________________________________________________________________
ECHO.
ECHO Locating Thumbs.db, Please Wait . .
echo.
ping -n 2 127.0.0.1 >nul
GOTO Thumbsdb2 
:ThumbScreen
mode 68 ,25
CLS
ECHO ___________________________________________________________________
ECHO Delete Thumbnail Cache
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Thumbnail Cache, Please Wait 
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Thumbnail Cache
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Thumbnail Cache, Please Wait . 
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Thumbnail Cache
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Thumbnail Cache, Please Wait . .
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Thumbnail Cache
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Thumbnail Cache, Please Wait . . .
ping -n 1 127.0.0.1 >nul
GOTO ThumbCache2
:HistoryScreen
mode 68 ,25
CLS
ECHO ___________________________________________________________________
ECHO Delete History
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting History, Please Wait
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete History
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting History, Please Wait .
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete History
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting History, Please Wait . .
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete History
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting History, Please Wait . . .
ping -n 1 127.0.0.1 >nul
GOTO History2
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
:ThumbsdbEnd
CLS
ECHO ___________________________________________________________________
ECHO Delete Thumbs.db
ECHO ___________________________________________________________________
ECHO.
ECHO Thumbs.db Files Have Been Deleted.
pause >nul
GOTO Menu
:ThumbCacheEnd
CLS
ECHO ___________________________________________________________________
ECHO Delete Thumbnail Cache
ECHO ___________________________________________________________________
ECHO.
ECHO Thumbnail Cache Has Been Deleted.
pause >nul
GOTO Menu
:HistoryEnd
CLS
ECHO ___________________________________________________________________
ECHO Delete History
ECHO ___________________________________________________________________
ECHO.
ECHO History Has Been Deleted.
pause >nul
GOTO Menu
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
ECHO           Thank You For Using PC Cleanup Utility v4 By Nicolas Hawrysh
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
