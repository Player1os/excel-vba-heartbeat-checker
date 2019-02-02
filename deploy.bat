@echo off

:: Set the deploy directory path environment variable.
set DEPLOY_DIRECTORY_PATH=H:\projects\heartbeat-checker

:: Create a fresh deploy directory at the specified path.
if exist "%DEPLOY_DIRECTORY_PATH%\" rmdir /s /q "%DEPLOY_DIRECTORY_PATH%"
mkdir "%DEPLOY_DIRECTORY_PATH%"

:: Copy all necessary files to the deploy directory.
copy /y "%~dp0emit.bat" "%DEPLOY_DIRECTORY_PATH%\" >nul
copy /y "%~dp0emit.vbs" "%DEPLOY_DIRECTORY_PATH%\" >nul
copy /y "%~dp0verify.bat" "%DEPLOY_DIRECTORY_PATH%\" >nul
copy /y "%~dp0verify.vbs" "%DEPLOY_DIRECTORY_PATH%\" >nul

:: Unset the deploy directory path environment variable.
set DEPLOY_DIRECTORY_PATH=
