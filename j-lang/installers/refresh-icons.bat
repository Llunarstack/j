@echo off
echo Refreshing Windows Icon Cache...
echo.

REM Kill Explorer to refresh icons
taskkill /f /im explorer.exe

REM Clear icon cache
del /f /s /q /a %LocalAppData%\IconCache.db
del /f /s /q /a %LocalAppData%\Microsoft\Windows\Explorer\iconcache*

REM Restart Explorer
start explorer.exe

echo.
echo Icon cache cleared and Explorer restarted.
echo Please wait a few seconds for icons to refresh.
echo.
pause
