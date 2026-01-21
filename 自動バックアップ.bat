@echo off
chcp 65001 >nul
echo Running Auto Backup...
powershell -ExecutionPolicy Bypass -File "%~dp0auto_backup.ps1"
echo.
echo Backup complete! Check log at: %USERPROFILE%\.claude\backup_log.txt
pause
