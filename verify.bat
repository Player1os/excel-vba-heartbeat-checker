@echo off

:: Execute the verify vbs script, reading the contents of the predetermined heartbeat checker timestamp file.
cscript /NoLogo "%~dp0verify.vbs" <"%APP_TIMESTAMP_FILE_PATH%"
