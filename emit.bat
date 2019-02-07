@echo off

:: Execute the emit vbs script, redirecting its output to the predetermined heartbeat checker timestamp file.
cscript /NoLogo "%~dp0emit.vbs" >"%APP_TIMESTAMP_FILE_PATH%"
