DBME_CopyToFile  -f "..\DatabaseTables.xlsm" -m "CopyAllCreateTableIfNotExistsSQL" -o "..\Schema.sql"
rem @powershell -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -WindowStyle Hidden createdb.ps1
@powershell -ExecutionPolicy Bypass ./createdb.ps1
pause
