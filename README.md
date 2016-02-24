Windows SFTP Directory Archiver
-------------------------------

This is project provides an example Windows batch file for archiving a directory and uploading it to an SFTP server.  It was written to work on Windows 7.  It may need to be modified to run on other versions of Windows.


Usage
-----

1. Download the upload.bat file contained in this repository to C:\Zipscene_Upload or another directory of your choosing.  If you decide to use a different directory, you will need to update the BIN_DIR variable in the batch file.
2. Download a copy of the [PuTTY SFTP binary](http://the.earth.li/~sgtatham/putty/latest/x86/psftp.exe) to the same directory as upload.bat.
3. Download a copy of the [7Zip command line version](http://www.7-zip.org/a/7za920.zip) and extract the 7za binary to the same directory as upload.bat.
4. Update STORE_NAME in the update.bat file to be unique for each computer running the batch file.
5. Update DATA_DIR in the update.bat file to point to the location of the files you wish to archive.
6. Update or comment out EXCLUDED_DATA_FOLDER in the update.bat file to exclude a folder from the archive.
7. Update SFTP_USER and SFTP_PASSWORD to the credentials provided by Zipscene.
8. Update your firewall to allow outbound connections on port 22.
9. Test that update.bat executes successfully and the generated file exists on the SFTP server.
10. Schedule update.bat to execute daily.  You can [use the Windows Task Scheduler](http://www.thewindowsclub.com/how-to-schedule-batch-file-run-automatically-windows-7) to accomplish this.





