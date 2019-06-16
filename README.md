# Heartbeat Checker

[![License](https://img.shields.io/github/license/Player1os/heartbeat-checker.svg)](https://github.com/Player1os/heartbeat-checker/blob/master/LICENSE)

A set of scripts for checking whether a server is alive from a client machine.

It is intended to be used when the following conditions are met:

1. The operating system on both machines is a version of Windows.
2. The only available communication channel between the machines is a shared directory.

## Deployment instructions

1. Create a copy of the `.env.reset.bat` script, name it `.env.set.bat` and modify it as follows:
	- Set the `DEPLOY_DIRECTORY_PATH` variable to a suitable location, where the contained scripts will be deployed. It is recommended
	to set this to a location on the shared directory, which is accessible from both machines.
	- Set the `APP_VERIFICATION_OFFSET_SEC` to an suitable numeric value.
2. Run the `deploy.bat` script to copy the required files to the deploy directory.
3. Using the **Task Scheduler** application, configure the `emit.bat` script to be regularly executed from the server machine
with an interval equal to half of the `APP_VERIFICATION_OFFSET_SEC` time span.
4. Using the **Task Scheduler** application, configure the `verify.bat` script to be regularly executed from the client machine
with an interval equal to half of the `APP_VERIFICATION_OFFSET_SEC` time span but offset by a quarter of the `APP_VERIFICATION_OFFSET_SEC`
time span in relation to the previous configuration of the `emit.bat` script.
