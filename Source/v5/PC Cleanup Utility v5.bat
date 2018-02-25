::**********************************************************************************************************************************************************************
::PLEASE READ :
::There is NO waranty of any kind on these files.

::This file may be redistributed as long as you include this info in the file: 
::Copyright (c) 2015 Nicolas Hawrysh
::All Rights Reserved

::Use common sense, Incorrect Environment Variables and or incorrect editing of this file may result in damage or loss of data.
::These files has been tested and works on Windows XP, Windows Vista And Windows 7.

::For the PC Cleanup Utility and the Cleaner Settings you must right-click and run as administrator unless you are using Windows XP, then just
::make sure that you are running it on a administrator account.

::These files use environment variables to locate your "%systemdrive%", "%LocalAppData%" (For Vista And Higher), "%userprofile%" , %TEMP% , %TMP% and %windir%.
::NOTE: To check your environmental variables, type "SET" without the quotation marks in cmd, it will display a list of your variables and there paths.

::Please make sure if you are using Windows XP, that you have NO "users", "Users" or "USERS" folder in the root of your %systemdrive%. Ex: C:\Users. 

::NOTE: It's very rare that these files need to be modified to run right on your computer, but you may have incorrectly changed variables such as %userprofile%, 
::%TEMP% and %systemdrive%

::If you have any questions/concerns or find any bugs please send me a Private Message at http://www.instructables.com/member/xp4xbox/ or 
::email me at *****@gmail.com.
::**********************************************************************************************************************************************************************

::Start Of Code
@ECHO OFF
TITLE PC Cleanup Utility v5
Color 2e & CLS
cls
ECHO   PC Cleanup Utility Made By Nicolas Hawrysh, a Windows Cleanup Tool.
ECHO                                Version 5
ECHO  ---------------------------------------------------------------------
ECHO                   Copyright (c) Nicolas Hawrysh 2015    
ECHO                          All Rights Reserved  
ECHO  ---------------------------------------------------------------------
ECHO         Use Notepad Or Edit To View File Contents Before Running!
ECHO         This File Will Work Fine As-Is On Standard Windows Setups
ECHO         See http://www.instructables.com/id/PC-Cleanup-Utility-v3/
ECHO             For Even More Information And For Newer Versions.
ECHO                              -------------                   
ECHO  This Batch File Aggressively Cleans Up Unnecessary Files On Your Computer.
ECHO  Note 1: You Will Need To Right-Click And Run As Administrator.
ECHO  Note 2: All Other Apps Should Be Closed Before Running This.
ECHO  Note 3: You Will Need To Restart Your PC For Some Changes To Take Effect.
ECHO  Note 4: This File Uses Environmental Variables To Locate Several Directories 
ECHO  Including Your Windows Home Directory, Your Temp Directory And More.
ECHO  *Read This File* In Notepad Or Edit For More Information.
ECHO  ---------------------------------------------------------------------
ECHO If You Haven't Followed The Instructions Above, Hit Ctrl-C To Abort; Otherwise
pause
:check
::::::::::::::::::::::::::::::::::::
openfiles > NUL 2>&1 
if %ERRORLEVEL% NEQ 0 GOTO noadmin
::::::::::::::::::::::::::::::::::::
cd \ >NUL
cd /d "%systemdrive%" >NUL
SETLOCAL
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do (if %%i==Version (set v=%%j.%%k) else (set v=%%i.%%j))
if %v% LSS 6 (
if exist "%systemdrive%\Users" (
cls
ECHO This Program Will Not Work Because You Are Using Windows XP And
ECHO You Have A Folder In Your *systemdrive* Called Users. To 
ECHO Fix This Problem, Rename The %systemdrive%\Users Folder To Something Else.
Pause >NUL
EXIT
))
if %v% GEQ 6 (
if not exist "%systemdrive%\Users" md Users
)
ENDLOCAL
IF "%windir%" == "" GOTO ERROR
IF "%systemdrive%" == "" GOTO ERROR
IF "%userprofile%" == "" GOTO ERROR
IF "%TEMP%" == "" GOTO ERROR
IF "%TMP%" == "" GOTO ERROR
:Menu
cd \ >NUL
cd /d "%systemdrive%" >NUL
if exist "%systemdrive%\Users" (
if exist "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations" mode 34,28 & GOTO JumpMenu
mode 34,27
) else (
mode 34,23
)
:JumpMenu
CLS
ECHO _________________________________
ECHO PC Cleanup Utility v5
ECHO _________________________________
ECHO X Exit
if exist "%systemdrive%\Users" (
ECHO F Delete Firefox Info
ECHO G Delete Google Chrome Info
ECHO O Delete Opera Info
)
ECHO I Delete Temporary Internet Files
ECHO H Delete History
ECHO C Delete Internet Cookies
ECHO T Delete Temp Files
ECHO D Delete Icon Cache
ECHO U Delete Thumbnail Cache
ECHO R Delete Recent Documents
ECHO B Delete Thumbs.db
ECHO L Delete Windows Log Files
ECHO N Delete Run History
if exist "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations" (
ECHO J Clear Jump List
)
ECHO Y Clear Your IE Tracks
if exist "%systemdrive%\Users" (
ECHO A Clear Clipboard
) 
ECHO V View Files To Delete
ECHO E Empty Recycle Bin
::ECHO F Disk Defragmenter
ECHO P Permenant File Deletion
ECHO M More Options
ECHO _________________________________
SET N=
SET /P N=Type Selection:
IF NOT DEFINED N (
GOTO Menu
) 
set /a ifnumber=%N% * 1
if %ifnumber% GTR 0 (
ECHO You Must Enter A Letter!
pause >nul
GOTO Menu
)
if exist "%systemdrive%\Users" (
IF /I "%N%"=="f" GOTO FirefoxInfo
IF /I "%N%"=="g" GOTO ChromeInfo
IF /I "%N%"=="o" GOTO OperaInfo 
IF /I "%N%"=="a" GOTO ClearClip
)
if exist "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations" (
IF /I "%N%"=="j" GOTO ClearJumpList
)
IF /I "%N%"=="x" GOTO Exit
IF /I "%N%"=="i" GOTO InternetFiles
IF /I "%N%"=="c" GOTO Cookies
IF /I "%N%"=="r" GOTO Recent
IF /I "%N%"=="t" GOTO Temp
IF /I "%N%"=="d" GOTO IconCache
IF /I "%N%"=="m" GOTO More
IF /I "%N%"=="h" GOTO History
IF /I "%N%"=="u" GOTO ThumbCacheCheck
IF /I "%N%"=="b" GOTO Thumbsdb
IF /I "%N%"=="p" GOTO PermenantFile
IF /I "%N%"=="e" GOTO EmptyRecycle
IF /I "%N%"=="v" GOTO ViewFiles
IF /I "%N%"=="l" GOTO LogFiles
IF /I "%N%"=="n" GOTO ClearRunHistory
IF /I "%N%"=="y" (
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255 2>NUL >NUL & GOTO Menu
)
::IF /I "%N%"=="f" GOTO Defrag
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
del /f /s /q "%LocalAppData%\Microsoft\Windows\Temporary Internet Files\*.*" 2>NUL >NUL
FOR /D %%p IN ("%LocalAppData%\Microsoft\Windows\Temporary Internet Files\Content.IE5\*.*") DO rmdir "%%p" /s /q 2>NUL >NUL
FOR /D %%p IN ("%LocalAppData%\Microsoft\Windows\Temporary Internet Files\Low\Content.IE5\*.*") DO rmdir "%%p" /s /q 2>NUL >NUL
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
::taskkill /f /im explorer.exe 2>NUL >NUL
del /q "%LocalAppData%\Iconcache.db" /a 2>NUL >NUL
) ELSE (
IF EXIST "%windir%\system32\TweakUI.exe" GOTO TweakUI
::taskkill /f /im explorer.exe 2>NUL >NUL
del /q "%userprofile%\Local Settings\Application Data\Iconcache.db" /a 2>NUL >NUL
)
::start explorer.exe 2>NUL >NUL
:TweakUI
GOTO IconCacheEnd
:History
GOTO HistoryScreen
:History2
IF EXIST "%systemdrive%\Users" (
del /f /s /q "%LocalAppData%\Microsoft\Windows\History\*.*" 2>NUL >NUL
) else (
del /f /s /q "%userprofile%\Local Settings\History\*.*" 2>NUL >NUL
)
GOTO HistoryEnd
:ThumbCacheCheck
if exist "%systemdrive%\Users" GOTO ThumbCache
cd \ >NUL
cd /d "%TMP%" >NUL
echo Msgbox "This Option Does Not Work On Windows XP" ,16 , "Error" > Error.vbs
start Error.vbs
GOTO Menu
:ThumbCache
GOTO ThumbScreen
:ThumbCache2
del /f /s /q /a "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" 2>NUL >NUL
GOTO ThumbCacheEnd
:Thumbsdb
GOTO ThumbsdbScreen
:Thumbsdb2 
cd \ >NUL & cd /d "%systemdrive%" >NUL
del /q /f /s /a Thumbs.db 2>NUL
if exist "d:\" (
cd \ >NUL
cd /d "d:\" 2>NUL >NUL
del /q /f /s /a Thumbs.db 2>NUL
)
pause
cd \ >NUL & cd /d "%systemdrive%" >NUL
GOTO ThumbsdbEnd
:ClearClip
ECHO >NUL | CLIP
cd \ >NUL & cd /d "%TMP%" >NUL
echo msgbox "Clipboard Cleared",64, "Clear Clipboard" > clip.vbs
start clip.vbs
GOTO Menu
:ClearRunHistory
REG Delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /F 2>NUL >NUL
::taskkill /f /im explorer.exe 2>NUL >NUL
cd \ >NUL & cd /d "%TMP%" >NUL
::start explorer.exe 2>NUL >NUL
echo msgbox "Run History Deleted",64, "Delete Run History" > clip.vbs
start clip.vbs
GOTO Menu
:LogFiles
GOTO LogFilesScreen
:LogFiles2
cd \ >NUL & cd /d "%windir%" >NUL
DEL *.log /S /F /Q 2>NUL >NUL
GOTO LogFilesEnd
:ClearJumpList
del /F /Q %APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\* 2>NUL >NUL
del /F /Q %APPDATA%\Microsoft\Windows\Recent\CustomDestinations\* 2>NUL >NUL
cd \ >NUL & cd /d "%TMP%" >NUL
echo msgbox "Jump List Cleared",64, "Clear Jump List" > clip.vbs
start clip.vbs
GOTO Menu
::*****************************************************************************************************************************
:FirefoxInfo
if not exist "%LocalAppData%\Mozilla\Firefox\Profiles" (
cd \ >NUL
cd /d "%TMP%" >NUL
ECHO msgbox "Firefox Directory Not Found", 16, "Error" > Error.vbs
start Error.vbs
GOTO Menu
)
taskkill /f /im firefox.exe 2>NUL >NUL
set browser=Firefox
set browsertitle=FirefoxInfo2
GOTO BrowserInfoScreen
:FirefoxInfo2
set firefoxDataDir=%LocalAppData%\Mozilla\Firefox\Profiles
del /f /s /q "%firefoxDataDir%" 2>NUL >NUL
rd /s /q "%firefoxDataDir%" 2>NUL >NUL
for /d %%x in (%userprofile%\AppData\Roaming\Mozilla\Firefox\Profiles\*) do del /f /s /q %%x\*sqlite 2>NUL >NUL
GOTO BrowserInfoEnd
:ChromeInfo
if not exist "%LocalAppData%\Google\Chrome\User Data" (
cd \ >NUL
cd /d "%TMP%" >NUL
ECHO msgbox "Google Chrome Directory Not Found", 16, "Error" > Error.vbs
start Error.vbs
GOTO Menu
)
Taskkill /F /IM chrome.exe 2>NUL >NUL 
set browser=Google Chrome
set browsertitle=ChromeInfo2
GOTO BrowserInfoScreen
:ChromeInfo2
set ChromeDir=%LocalAppData%\Google\Chrome\User Data
del /f /s /q "%ChromeDir%" 2>NUL >NUL
rd /s /q "%ChromeDir%" 2>NUL >NUL
GOTO BrowserInfoEnd
:OperaInfo
if not exist "%LocalAppData%\Opera\Opera" (
cd \ >NUL
cd /d "%TMP%" >NUL
ECHO msgbox "Opera Directory Not Found", 16, "Error" > Error.vbs
start Error.vbs
GOTO Menu
)
taskkill /F /IM opera.exe 2>NUL >NUL
set browser=Opera
set browsertitle=OperaInfo2
GOTO BrowserInfoScreen
:OperaInfo2
set OperaDataDir=%LocalAppData%\Opera\Opera
set OperaDataDir2=%userprofile%\AppData\Roaming\Opera\Opera
del /f /s /q "%OperaDataDir%" 2>NUL >NUL
rd /s /q "%OperaDataDir%" 2>NUL >NUL
del /f /s /q "%OperaDataDir2%" 2>NUL >NUL
rd /s /q "%OperaDataDir2%" 2>NUL >NUL
GOTO BrowserInfoEnd
::*****************************************************************************************************************************
:ViewFiles
cd \ >NUL
cd /d "%TMP%" >NUL
ECHO Generating List, Please Wait . .
TYPE NUL > ViewFiles.txt
ECHO Temporary Internet Files: > ViewFiles.txt
ECHO. >> ViewFiles.txt
if exist "%systemdrive%\Users" (
dir /b /s "%LocalAppData%\Microsoft\Windows\Temporary Internet Files\" >> ViewFiles.txt 2>NUL
) else (
dir /b /s "%userprofile%\Local Settings\Temporary Internet Files\" >> ViewFiles.txt 2>NUL
)
ECHO. >> ViewFiles.txt
ECHO. >> ViewFiles.txt
ECHO History: >> ViewFiles.txt
ECHO. >> ViewFiles.txt
if exist "%systemdrive%\Users" (
dir /b /s "%LocalAppData%\Microsoft\Windows\History\" >> ViewFiles.txt 2>NUL
) else (
dir /b /s "%userprofile%\Local Settings\History\" >> ViewFiles.txt 2>NUL
)
ECHO. >> ViewFiles.txt
ECHO. >> ViewFiles.txt
ECHO Internet Cookies: >> ViewFiles.txt
ECHO. >> ViewFiles.txt
if exist "%systemdrive%\Users" (
dir /b "%userprofile%\AppData\Roaming\Microsoft\Windows\Cookies\" >> ViewFiles.txt 2>NUL
IF EXIST "%userprofile%\AppData\Roaming\Microsoft\Windows\Cookies\Low" dir /b "%userprofile%\AppData\Roaming\Microsoft\Windows\Cookies\Low\" >>ViewFiles.txt 2>NUL
) else (
dir /b "%userprofile%\Cookies\" >>ViewFiles.txt 2>NUL
)
ECHO. >> ViewFiles.txt
ECHO. >> ViewFiles.txt
ECHO Temp Files: >> ViewFiles.txt
ECHO. >> ViewFiles.txt
dir /b /s "%TEMP%" >>ViewFiles.txt 2>NUL
if not "%TEMP%"=="%TMP%" dir /b /s "%TMP%" >>ViewFiles.txt 2>NUL
dir /b /s "%windir%\Temp\" >>ViewFiles.txt 2>NUL
if exist "%systemdrive%\Temp" (
dir /b /s "%systemdrive%\Temp" >>ViewFiles.txt 2>NUL
)
ECHO. >> ViewFiles.txt
ECHO. >> ViewFiles.txt
ECHO Icon Cache: >> ViewFiles.txt
ECHO. >> ViewFiles.txt
if exist "%systemdrive%\Users" (
ECHO %LocalAppData%\Iconcache.db >>ViewFiles.txt
) else (
ECHO %userprofile%\Local Settings\Application Data\Iconcache.db >>ViewFiles.txt
)
if not exist "%systemdrive%\Users" GOTO ViewFilesXPT
ECHO. >> ViewFiles.txt
ECHO. >> ViewFiles.txt
ECHO Thumbnail Cache: >> ViewFiles.txt
ECHO. >> ViewFiles.txt
dir /b /s /a "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >>ViewFiles.txt 2>NUL
:ViewFilesXPT
ECHO. >> ViewFiles.txt
ECHO. >> ViewFiles.txt
ECHO Recent Documents (In Start Menu): >> ViewFiles.txt
ECHO. >> ViewFiles.txt
if exist "%systemdrive%\Users" (
dir /b "%userprofile%\AppData\Roaming\Microsoft\Windows\Recent\" >> ViewFiles.txt 2>NUL
) else (
dir /b "%userprofile%\Recent\*.*" >> ViewFiles.txt 2>NUL
)
if exist "%systemdrive%\Users" (
if exist "%LocalAppData%\Google\Chrome\User Data" (
ECHO. >> ViewFiles.txt
ECHO. >> ViewFiles.txt
ECHO Google Chrome Info: >> ViewFiles.txt
ECHO. >> ViewFiles.txt
dir /b /s "%LocalAppData%\Google\Chrome\User Data" >> ViewFiles.txt 2>NUL
))
if exist "%systemdrive%\Users" (
if exist "%LocalAppData%\Mozilla\Firefox\Profiles" (
ECHO. >> ViewFiles.txt
ECHO. >> ViewFiles.txt
ECHO Firefox Info: >> ViewFiles.txt
ECHO. >> ViewFiles.txt
dir /b /s "%LocalAppData%\Mozilla\Firefox\Profiles" >> ViewFiles.txt 2>NUL
dir /b /s "%userprofile%\AppData\Roaming\Mozilla\Firefox\Profiles\*\*sqlite" >> ViewFiles.txt 2>NUL
))
if exist "%systemdrive%\Users" (
if exist "%LocalAppData%\Opera\Opera" (
ECHO. >> ViewFiles.txt
ECHO. >> ViewFiles.txt
ECHO Opera Info: >> ViewFiles.txt
ECHO. >> ViewFiles.txt
dir /b /s "%LocalAppData%\Opera\Opera" >>ViewFiles.txt 2>NUL
dir /b /s "%userprofile%\AppData\Roaming\Opera\Opera" >>ViewFiles.txt 2>NUL
))
ECHO. >> ViewFiles.txt
ECHO. >> ViewFiles.txt
ECHO Windows Log Files: >> ViewFiles.txt
ECHO. >> ViewFiles.txt
dir /b /s "%windir%\*.log" >>ViewFiles.txt 2>NUL
if exist "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations" (
ECHO. >> ViewFiles.txt
ECHO. >> ViewFiles.txt
ECHO Clear Jump List: >> ViewFiles.txt
ECHO. >> ViewFiles.txt
dir /b %APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\* >> ViewFiles.txt 2>NUL
dir /b %APPDATA%\Microsoft\Windows\Recent\CustomDestinations\* >> ViewFiles.txt 2>NUL
)
start ViewFiles.txt
cd \ >NUL
cd /d "%systemdrive%" >NUL
GOTO Menu
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
cd /d "%TMP%" >NUL
echo Msgbox "Recycle Bin Has Already Been Emptied." ,16 , "Error" > Error.vbs
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
::*****************************************************************************************************************************
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
::*****************************************************************************************************************************
:BrowserInfoScreen
mode 68 ,25
CLS
ECHO ___________________________________________________________________
ECHO Delete %browser% Info
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Cache, Please Wait 
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete %browser% Info
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Cookies, Please Wait . 
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete %browser% Info
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting History, Please Wait . .
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete %browser% Info
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting History, Please Wait . . .
ping -n 1 127.0.0.1 >nul
GOTO %browsertitle%
:LogFilesScreen
mode 68 ,25
CLS
ECHO ___________________________________________________________________
ECHO Delete Windows Log Files
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Windows Log Files, Please Wait
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Windows Log Files
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Windows Log Files, Please Wait .
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Windows Log Files
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Windows Log Files, Please Wait . .
ping -n 2 127.0.0.1 >nul
CLS
ECHO ___________________________________________________________________
ECHO Delete Windows Log Files
ECHO ___________________________________________________________________
ECHO.
ECHO Deleting Windows Log Files, Please Wait . . .
ping -n 1 127.0.0.1 >nul
GOTO LogFiles2
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
::*****************************************************************************************************************************
:BrowserInfoEnd
CLS
ECHO ___________________________________________________________________
ECHO Delete %browser% Info
ECHO ___________________________________________________________________
ECHO.
ECHO %browser% Info Has Been Deleted.
pause >nul
GOTO Menu
:LogFilesEnd
CLS
ECHO ___________________________________________________________________
ECHO Delete Windows Log Files
ECHO ___________________________________________________________________
ECHO.
ECHO Windows Log Files Have Been Deleted.
pause >nul
GOTO Menu
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
ECHO           Thank You For Using PC Cleanup Utility v5 By Nicolas Hawrysh
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
ECHO.
ECHO Press any key to abort . . .
PAUSE >nul
EXIT
:noadmin
if exist "%systemdrive%\Users" (
cd \ >NUL & cd /d "%TMP%" >NUL
echo msgbox "You Must Right-Click And Run As Administrator.", 16, "Error" > Error.vbs
start Error.vbs
EXIT
)
cd \ >NUL & cd /d "%TMP%" >NUL
echo msgbox "You Must Be Running This File On A Administrator Preveliged Account.", 16, "Error" > Error.vbs
start Error.vbs
EXIT

::*****************************************************************************************************************************
::End Of Code
