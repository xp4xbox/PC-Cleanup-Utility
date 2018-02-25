@ECHO OFF
mode 62,24
TITLE Cleaner Settings
COLOR 2e
cd \ >NUL
cd /d "%systemdrive%" >NUL
:check
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
::::::::::::::::::::::::::::::::::::
openfiles > NUL 2>&1 
if %ERRORLEVEL% NEQ 0 GOTO noadmin
GOTO aftherend
::::::::::::::::::::::::::::::::::::
:noadmin
if %v% GEQ 6 (
cd \ >NUL & cd /d "%TMP%" >NUL
echo msgbox "You Must Right-Click And Run As Administrator.", 16, "Error" > Error.vbs
start Error.vbs
EXIT
)
cd \ >NUL & cd /d "%TMP%" >NUL
echo msgbox "You Must Be Running This File On A Administrator Preveliged Account.", 16, "Error" > Error.vbs
start Error.vbs
EXIT
ENDLOCAL
:aftherend
cls
if not exist Cleaner_Settings.sav (
goto sets
) else (
ECHO You Have Already Configured Your Settings.
ECHO.
ECHO Press Any Key To Reset Your Settings Or Press Ctrl-C To Abort.
PAUSE >NUL
del /f /q Cleaner_Settings.sav /a
)
:sets
set Jumplist=2
set logfiles=2
set SrubEI=2
set Opera=2
set Chrome=2
set firefox=2
set internetfiles=2
set cookies=2
set recent=2
set temp=2
set iconcache=2
set history=2
set thumbcache=2
set DiskCleanup=2
set ClearClip=2
set run=2
:Menu
cd \ >NUL & cd /d "%systemdrive%" >NUL
cls
ECHO What Actions Do You Want When You Run The Cleaner? 
ECHO.
if not exist "%systemdrive%\Users" goto skipxp1
ECHO F Delete Firefox Info ) %fire%
ECHO G Delete Google Chrome Info ) %google%
ECHO O Delete Opera Info ) %opb%
ECHO U Delete Thumbnail Cache ) %u%
ECHO A Clear Clipboard ) %ccc%
if exist "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations" ECHO J Clear Jump List ) %jplt%
:skipxp1
ECHO Y Clear Your IE Tracks ) %ie%
ECHO I Delete Temporary Internet Files ) %b%
ECHO C Delete Internet Cookies ) %c%
ECHO T Delete Temp Files ) %e%
ECHO D Delete Icon Cache ) %f%
ECHO R Delete Recent Documents ) %d%
ECHO H Delete History ) %h%
ECHO N Delete Run History ) %runhi%
ECHO L Delete Windows Log Files ) %lol%
ECHO E Clear Settings
ECHO S Save Settings
ECHO.
SET A=
SET /P A=Type Selection:
IF NOT DEFINED A (
GOTO Menu
)
set /a ifnumber=%A% * 1
if %ifnumber% GTR 0 (
ECHO.
ECHO You Must Enter A Letter!
pause >nul
GOTO Menu
)
if exist "%systemdrive%\Users" (
IF /I "%A%"=="u" set u=Selected & set thumbcache=1 & GOTO Menu
IF /I "%A%"=="f" GOTO Firefoxsets
IF /I "%A%"=="g" GOTO Chromesets
IF /I "%A%"=="o" GOTO Operasets
IF /I "%A%"=="a" set ccc=Selected & set ClearClip=1 & GOTO Menu
)
if exist "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations" (
IF /I "%A%"=="j" set jplt=Selected & set Jumplist=1 & GOTO Menu
)
IF /I "%A%"=="y" set ie=Selected & set SrubEI=1 & GOTO Menu
IF /I "%A%"=="i" set b=Selected & set internetfiles=1 & GOTO Menu
IF /I "%A%"=="c" set c=Selected & set cookies=1 & GOTO Menu
IF /I "%A%"=="r" set d=Selected & set recent=1 & GOTO Menu
IF /I "%A%"=="t" set e=Selected & set temp=1 & GOTO Menu
IF /I "%A%"=="d" set f=Selected & set iconcache=1 & GOTO Menu
IF /I "%A%"=="h" set h=Selected & set history=1 & GOTO Menu
IF /I "%A%"=="l" set lol=Selected & set logfiles=1 & GOTO LogfilesWarning
IF /I "%A%"=="n" set runhi=Selected & set run=1 & GOTO Menu
IF /I "%A%"=="e" GOTO ClearSettings 
IF /I "%A%"=="s" GOTO Save
ECHO.
ECHO Invalid Choice, Please Try Again!
PAUSE >NUL
GOTO Menu 
:BrowserWarning
cd \ >NUL & cd /d "%TMP%" >NUL
echo msgbox "This Will Delete: Cookies, Cache And History",48, "Warning" > Warning.vbs
start Warning.vbs
GOTO Menu
:Firefoxsets
if exist "%LocalAppData%\Mozilla\Firefox" (
set fire=Selected & set firefox=1 & GOTO BrowserWarning
) else (
cd \ >NUL & cd /d "%TMP%" >NUL
ECHO msgbox "Firefox Directory Not Found", 16, "Error" > Error.vbs
start Error.vbs
GOTO Menu
)
:Chromesets
if exist "%LocalAppData%\Google\Chrome" (
set google=Selected & set Chrome=1 & GOTO BrowserWarning
) else (
cd \ >NUL & cd /d "%TMP%" >NUL
ECHO msgbox "Google Chrome Directory Not Found", 16, "Error" > Error.vbs
start Error.vbs
GOTO Menu
)
:Operasets
if exist "%LocalAppData%\Opera" (
set opb=Selected & set Opera=1 & GOTO BrowserWarning
) else (
cd \ >NUL & cd /d "%TMP%" >NUL
ECHO msgbox "Opera Directory Not Found", 16, "Error" > Error.vbs
start Error.vbs
GOTO Menu
)
:LogfilesWarning
cd \ >NUL & cd /d "%TMP%" >NUL
echo msgbox "This May Significantly Increase The Amount Of Time The Cleaning Takes",48, "Warning" > Warning.vbs
start Warning.vbs
GOTO Menu
:ClearSettings
set jplt=
set runhi=
set lol=
set ccc=
set ie=
set opb=
set google=
set fire=
set b=
set c=
set d=
set e=
set f=
set h=
set u=
set adc=
set logfiles=2
set ClearClip=2
set internetfiles=2
set cookies=2
set recent=2
set temp=2
set iconcache=2
set history=2
set thumbcache=2
set DiskCleanup=2
set firefox=2
set Chrome=2
set Opera=2
set SrubEI=2
set run=2
set Jumplist=2
GOTO Menu
:Save
(echo internetfiles=%internetfiles%)>> Cleaner_Settings.sav
(echo cookies=%cookies%)>> Cleaner_Settings.sav
(echo recent=%recent%)>> Cleaner_Settings.sav
(echo temp=%temp%)>> Cleaner_Settings.sav
(echo iconcache=%iconcache%)>> Cleaner_Settings.sav
(echo history=%history%)>> Cleaner_Settings.sav
(echo thumbcache=%thumbcache%)>> Cleaner_Settings.sav
(echo DiskCleanup=%DiskCleanup%)>> Cleaner_Settings.sav
(echo firefox=%firefox%)>> Cleaner_Settings.sav
(echo Chrome=%Chrome%)>> Cleaner_Settings.sav
(echo Opera=%Opera%)>> Cleaner_Settings.sav
(echo SrubEI=%SrubEI%)>> Cleaner_Settings.sav
(echo ClearClip=%ClearClip%)>> Cleaner_Settings.sav
(echo logfiles=%logfiles%)>> Cleaner_Settings.sav
(echo run=%run%)>> Cleaner_Settings.sav
(echo Jumplist=%Jumplist%)>> Cleaner_Settings.sav
ATTRIB +R +H Cleaner_Settings.sav
CLS
ECHO Your Settings Have Been Saved!
PAUSE >NUL
EXIT
