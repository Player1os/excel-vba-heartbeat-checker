@echo off
setlocal enabledelayedexpansion
setlocal enableextensions

:: Set environment variables.
call "%~dp0.env.set.bat"

:: Create a fresh deploy directory at the specified path.
if exist "%DEPLOY_DIRECTORY_PATH%\" (
	rmdir /s /q "%DEPLOY_DIRECTORY_PATH%"
)
mkdir "%DEPLOY_DIRECTORY_PATH%"

:: Copy all necessary files to the deploy directory.
copy /y "%~dp0.env.reset.bat" "%DEPLOY_DIRECTORY_PATH%\" >nul
copy /y "%~dp0.env.set.bat" "%DEPLOY_DIRECTORY_PATH%\" >nul
copy /y "%~dp0emit.bat" "%DEPLOY_DIRECTORY_PATH%\" >nul
copy /y "%~dp0emit.vbs" "%DEPLOY_DIRECTORY_PATH%\" >nul
copy /y "%~dp0verify.bat" "%DEPLOY_DIRECTORY_PATH%\" >nul
copy /y "%~dp0verify.vbs" "%DEPLOY_DIRECTORY_PATH%\" >nul

:: Emit the initial heartbeat.
call "%DEPLOY_DIRECTORY_PATH%\emit.bat"

:: Reset environment variables.
call "%~dp0.env.reset.bat"
