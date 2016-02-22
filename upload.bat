@ECHO OFF


REM ############## START License ###############

REM The MIT License (MIT)
REM Copyright (c) 2016 Zipscene LLC

REM Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal
REM in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
REM of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
REM
REM The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
REM
REM THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
REM MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
REM ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
REM THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

REM ############### END License ################


REM NOTE: This file was written for use on a Windows 7 system. It may need to be adapted to work on other versions of Windows.


SETLOCAL


REM ############## START Configuration Options ###############

REM Directory containing 7-Zip and SFTP binaries
SET BIN_DIR=C:\Zipscene_Upload

REM Full path to 7Zip binary
SET BIN_7ZIP=%BIN_DIR%\7za.exe

REM Full path to Putty SFTP binary
SET BIN_PSFTP=%BIN_DIR%\psftp.exe



REM Directory containing data to be uploaded
SET DATA_DIR=C:\My Data Directory

REM Exclude a folder inside of DATA_DIR
REM This is optional. Comment it out or delete it if you do not want to use it.
SET EXCLUDED_DATA_FOLDER=Folder To Exclude

REM Temporary directory used to create archive file.
SET TMP_DIR=%TEMP%



REM Name of SFTP server
SET SFTP_SERVER=uploads.zipscene.com

REM User for SFTP server
SET SFTP_USER=my_user

REM Password for SFTP server
SET SFTP_PASSWORD=my password

REM ############### END Configuration Options ################


REM Remember initial directory
SET INITIAL_DIR=%CD%


REM Change to the data directory
cd "%DATA_DIR%"

REM Use the current date/time as the file name
SET ZIP_FILE=%date:~-4%-%date:~4,2%-%date:~7,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%.zip
SET PUTTY_BATCH_FILE=%date:~-4%-%date:~4,2%-%date:~7,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%.txt

REM Remove whitespace
SET ZIP_FILE=%ZIP_FILE: =%
SET PUTTY_BATCH_FILE=%PUTTY_BATCH_FILE: =%


REM Zip up the data
IF DEFINED EXCLUDED_DATA_FOLDER (
    %BIN_7ZIP% a -tzip "%TMP_DIR%\%ZIP_FILE%" * -xr!"%EXCLUDED_DATA_FOLDER%"
) ELSE (
    %BIN_7ZIP% a -tzip "%TMP_DIR%\%ZIP_FILE%" *
)


REM Generate batch file containing SFTP commands
@echo cd incoming > "%TMP_DIR%\%PUTTY_BATCH_FILE%"
@echo put "%TMP_DIR%\%ZIP_FILE%" >> "%TMP_DIR%\%PUTTY_BATCH_FILE%"
@echo quit >> "%TMP_DIR%\%PUTTY_BATCH_FILE%"


REM Upload the zip file
%BIN_PSFTP% -l "%SFTP_USER%" -pw "%SFTP_PASSWORD%" -b "%TMP_DIR%\%PUTTY_BATCH_FILE%" "%SFTP_SERVER%"


REM Cleanup the files
del "%TMP_DIR%\%ZIP_FILE%"
del "%TMP_DIR%\%PUTTY_BATCH_FILE%"


REM Change back to the initial directory
cd %INITIAL_DIR%


ENDLOCAL
