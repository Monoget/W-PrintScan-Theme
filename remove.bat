@echo off
for %%f in (*.html) do (
    call :RemoveFourthLine "%%f"
    call :RemoveLastLine "%%f"
)
exit /b

:RemoveFourthLine
setlocal enabledelayedexpansion
set "file=%~1"
set "tempfile=%file%.tmp"
set "counter=0"
(
    for /f "delims=" %%a in ('type "%file%"') do (
        set /a counter+=1
        if !counter! neq 4 echo %%a
    )
) > "%tempfile%"
move /y "%tempfile%" "%file%" > nul
exit /b

:RemoveLastLine
setlocal enabledelayedexpansion
set "file=%~1"
set "tempfile=%file%.tmp"
set "counter=0"
(
    for /f "delims=" %%a in ('type "%file%" ^| find /c /v ""') do set "total=%%a"
    for /f "delims=" %%a in ('type "%file%"') do (
        set /a counter+=1
        if !counter! lss !total! echo %%a
    )
) > "%tempfile%"
move /y "%tempfile%" "%file%" > nul
exit /b
