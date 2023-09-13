@echo off
echo %CD%
echo WARNING: Close the GameMaker instance before running this
echo Press Enter to proceed...
pause > nul
cls
setlocal enabledelayedexpansion

::Registry key path
set /p "ChosenVersion=Enter GameMaker version (7, 8, 8.1, 8.2...): "
set "RegistryName=CodeColor"

::Check if ChosenVersion is 7 and change to its right color
if "%ChosenVersion%"=="7" (
    set "RegistryName=Color"
)

set "RegKey=HKEY_CURRENT_USER\Software\Game Maker\Version %ChosenVersion%\Preferences"

::File path
::Remove dot, for example 8.1 to 81
set "ChosenVersionNoDot=%ChosenVersion:.=%"
set "RegFile=GM%ChosenVersionNoDot%_MyTheme.reg"

::Create an empty .reg file and write this to it
echo Windows Registry Editor Version 5.00 > "%RegFile%"
echo [%RegKey%]>> "%RegFile%"

::Whether the current line is a "CodeColorN"
set IsColor=0

::Loop and export the registry values to our file
for /f "tokens=1,2*" %%A in ('reg query "%RegKey%"') do (
    set "Name=%%A"
    set "Type=%%B"
    set "ValueName=%%C"
    set IsColor=0

    ::Check whether the current line is a CodeColor
    if "!Name!" equ "%RegistryName%0" set IsColor=1
    if "!Name!" equ "%RegistryName%1" set IsColor=1
    if "!Name!" equ "%RegistryName%2" set IsColor=1
    if "!Name!" equ "%RegistryName%3" set IsColor=1
    if "!Name!" equ "%RegistryName%4" set IsColor=1
    if "!Name!" equ "%RegistryName%5" set IsColor=1
    if "!Name!" equ "%RegistryName%6" set IsColor=1
    if "!Name!" equ "%RegistryName%7" set IsColor=1
    if "!Name!" equ "%RegistryName%8" set IsColor=1
    if "!Name!" equ "%RegistryName%9" set IsColor=1
    if "!Name!" equ "%RegistryName%10" set IsColor=1
    if "!Name!" equ "%RegistryName%11" set IsColor=1

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