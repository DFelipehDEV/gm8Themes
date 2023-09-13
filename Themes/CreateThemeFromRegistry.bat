@echo off
echo %CD%
echo WARNING: Close GameMaker 8.2 before running this
echo Press Enter to proceed...
pause > nul
cls
setlocal enabledelayedexpansion

::Registry key path
set "RegKey=HKEY_CURRENT_USER\Software\Game Maker\Version 8.2\Preferences"

::File path
set "RegFile=MyTheme8.reg"

::Create an empty .reg file and write this to it
echo Windows Registry Editor Version 5.00 > "%RegFile%"
echo [HKEY_CURRENT_USER\Software\Game Maker\Version 8.2\Preferences]>> "%RegFile%"

::Whether the current line is a "CodeColorN"
set IsColor=0

::Loop and export the registry values to our file
for /f "tokens=1,2*" %%A in ('reg query "%RegKey%"') do (
    set "Name=%%A"
    set "Type=%%B"
    set "ValueName=%%C"
    set IsColor=0

    ::Check whether the current line is a CodeColor
    if "!Name!" equ "CodeColor0" set IsColor=1
    if "!Name!" equ "CodeColor1" set IsColor=1
    if "!Name!" equ "CodeColor2" set IsColor=1
    if "!Name!" equ "CodeColor3" set IsColor=1
    if "!Name!" equ "CodeColor4" set IsColor=1
    if "!Name!" equ "CodeColor5" set IsColor=1
    if "!Name!" equ "CodeColor6" set IsColor=1
    if "!Name!" equ "CodeColor7" set IsColor=1
    if "!Name!" equ "CodeColor8" set IsColor=1
    if "!Name!" equ "CodeColor9" set IsColor=1
    if "!Name!" equ "CodeColor10" set IsColor=1
    if "!Name!" equ "CodeColor11" set IsColor=1

    ::Write if this registry is named "CodeColorN"
    if !IsColor! equ 1 (        
        set "ValueName=!ValueName:x=0!"
        echo "!Name!"=%Type%dword:!ValueName!>> "%RegFile%"
    )
)

::Finish
echo Finished
echo Created %RegFile% at %CD%
pause
