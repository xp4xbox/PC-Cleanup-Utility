@ECHO OFF
TITLE  PC Utilities v2 by Nicolas Hawrysh
COLOR 1c & CLS
::**********************************************************************************************************************************************************************
::PLEASE READ :
::This file works on Windows XP, Windows Vista And Windows 7.
::If you are using Windows Vista or Windows 7, you must right click and run as administrator.
::All other apps should be closed before running this.
::There is NO waranty of any kind on this file.

::This file uses a environmental variable to locate your "%systemdrive%", please make sure that it is properly set.
::If the variable %systemdrive% does not point to your drive wich contains your windows folder, edit this file and replace those variables with the 
::drive that contains your windows folder such as C: (Make sure that you add a colon to the drive letter)

::NOTE: To check your "%systemdrive%", type "SET" without the quotation marks in cmd, it will display a list of your variables and there paths, look for "%systemdrive%" and
::if that drive contains your windows folder you are good to go.

::If you are using Windows Vista or Windows 7, make sure that you have a folder in your %systemdrive% called Users, such as C:\Users. 
::If you don't have one, create a dummie one.
::Please make sure if you are using Windows XP, that you have NO "users", "Users" or "USERS" folder in the root of your system drive. Ex: C:\Users. 

::The "Force a Defrag" is only if you are low on disk space, (Less than 10%-15%) (only works on Windows Vista & Windows XP) otherwise use the "Disk Defragmenter".

::**********************************************************************************************************************************************************************


ECHO   PC Utilities  Made By Nicolas Hawrysh, a Windows PC Tool.
ECHO                                Version 2
ECHO  ---------------------------------------------------------------------
ECHO    Any Part Of This File May Be Reproduced And Redistributed As Long
ECHO                          As You Give Me Credit.
ECHO  ---------------------------------------------------------------------
ECHO                          See  Link Here
ECHO          For Even More Information And For Newer Versions.
ECHO                              -------------                   
ECHO  This Batch File Will Help Keep The Health Of Your PC And Files.
ECHO  Note 1: All Other Apps Should Be Closed Before Running This.
ECHO  Note 2: This File Uses Environmental Variables To Locate "systemdrive"
ECHO  Note 3: If You Are Using Windows Vista Or Windows 7, 
ECHO  You Must Right Click And Run As Administrator.
ECHO  *Read This File* In Notepad Or Edit For More Information.
ECHO  ---------------------------------------------------------------------
ECHO If You Haven't Followed The Instructions Above, Hit Ctrl-C To Abort; Otherwise
pause


:Check
IF "%SystemDrive%" == "" GOTO ERROR2
:Menu
mode con: cols=25 lines=12
cls
ECHO ________________________
ECHO PC Utilities v2
ECHO ________________________
ECHO X Exit
ECHO D Disk Defragmenter
ECHO F Force a Defrag 
ECHO S System File Checker
ECHO C Check Disk
ECHO ________________________
SET M=
SET /P M=Type Selection:
IF NOT DEFINED M (
GOTO Menu
) 
IF /I "%M%"=="d" GOTO Defrag2
IF /I "%M%"=="x" GOTO Exit
IF /I "%M%"=="f" GOTO Defrag
IF /I "%M%"=="s" GOTO Sfc
IF /I "%M%"=="c" GOTO Chkdsk
ECHO Invalid Choice! & PAUSE >nul
GOTO Menu
:Exit
mode 80, 25
CLS
ECHO ________________________________________________________________________________
ECHO           ------------------------------------------------------------
ECHO           Thank You For Using PC Utility v2 By Nicolas Hawrysh
ECHO           ------------------------------------------------------------
ping -n 3 127.0.0.1 >nul
EXIT
:Defrag
mode 50, 20
IF EXIST %SystemDrive%\Users GOTO DefragVista
CLS
ECHO _________________________________________________
ECHO Force a Defrag
ECHO _________________________________________________
ECHO.
ECHO Please Type Your Drive Letter Of The 
ECHO.
ECHO Drive You Wish to Defrag : 
ECHO.
ECHO.
set /p defrag=
IF EXIST %defrag%:\ (
ECHO.
ECHO.
Defrag %defrag%: -f
GOTO Menu
) ELSE (
ECHO.
ECHO.
ECHO Invalid Drive, Please Try Again!
PAUSE >nul
GOTO Defrag
)
:DefragVista
CLS
ECHO _________________________________________________
ECHO Force a Defrag
ECHO _________________________________________________
ECHO.
ECHO Please Type Your Drive Letter Of The 
ECHO.
ECHO Drive You Wish to Defrag Or Type "All" to Defrag all Volumes :
ECHO.
ECHO.
set /p DefragVista=
IF /I "%DefragVista%"=="All" GOTO DefragVistaAll
IF EXIST %DefragVista%:\ (
ECHO.
ECHO.
Defrag %DefragVista%: -f
GOTO Menu
) ELSE (
ECHO.
ECHO.
ECHO Invalid Drive, Please Try Again!
PAUSE >nul
GOTO DefragVista
)
:DefragVistaAll
Defrag -c -f
GOTO Menu
:Defrag2
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
GOTO Defrag2
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
:Sfc
IF EXIST %SystemDrive%\Users (
CLS
ECHO _________________________________________________
ECHO System File Checker
ECHO _________________________________________________
ECHO.
sfc /scannow
GOTO Menu
) ELSE (
mode 50, 20
CLS
For /L %%a in (5,-1, 0) DO (
CLS
ECHO _________________________________________________
ECHO System File Checker
ECHO _________________________________________________
ECHO.
ECHO Please Enter Your Windows XP CD      %%a Seconds
ping -n 2 127.0.0.1 >nul
))
CLS
ECHO _________________________________________________
ECHO System File Checker
ECHO _________________________________________________
ECHO.
sfc /scannow
GOTO Menu
:Chkdsk
mode 50, 20
CLS
ECHO _________________________________________________
ECHO Check Disk
ECHO _________________________________________________
ECHO.
ECHO Please Type Your Drive Letter Of The 
ECHO.
ECHO Drive You Wish to Check For Errors : 
ECHO.
ECHO.
set /p check=
IF EXIST %check%:\ (
IF NOT EXIST %check%:\windows\system32 GOTO Chkdsk2
ECHO.
ECHO.
ECHO y > y.txt
chkdsk %check%: /r < y.txt
shutdown -r -t 0
EXIT
) ELSE (
ECHO.
ECHO.
ECHO Invalid Drive, Please Try Again!
PAUSE >nul
GOTO Chkdsk
)
:Chkdsk2
ECHO y > y.txt
chkdsk %check%: /r < y.txt
GOTO Menu
:ERROR
ECHO _________________________________________________
ECHO ERROR!
ECHO _________________________________________________
ECHO.
echo ERROR!
echo Please Fix The Code
PAUSE >nul
GOTO Menu
:ERROR2
CLS
ECHO ________________________________________________________________________________
ECHO Error!
ECHO ________________________________________________________________________________
ECHO.
ECHO There's A Problem With Your Environment Variable "systemdrive"
ECHO Please Edit This File Manually To Insert The Correct Path{s}
ECHO To The Referenced Directories.
ECHO.
ECHO Press any key to abort . . .
PAUSE >nul
EXIT
