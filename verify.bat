@echo off

:: Set environment variables.
call "%~dp0.env.set.bat"

:: Execute the verify vbs script, reading the contents of the predetermined heartbeat checker timestamp file.
cscript /NoLogo "%~dp0verify.vbs" <"%~dp0heartbeat.txt"

:: Reset envronment variables.
call "%~dp0.env.reset.bat"
