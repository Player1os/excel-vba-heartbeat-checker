@echo off

:: Set environment variables.
call "%~dp0.env.set.bat"

:: Execute the emit vbs script, redirecting its output to the predetermined heartbeat checker timestamp file.
cscript /NoLogo "%~dp0emit.vbs" >"%~dp0heartbeat.txt"

:: Reset environment variables.
call "%~dp0.env.reset.bat"
