@echo off
echo Starting PHP-CGI...

IF EXIST "C:\xampp\php\php-cgi.exe" (
    start "" "C:\xampp\php\php-cgi.exe" -b 127.0.0.1:9000
) ELSE (
    echo PHP-CGI executable not found!
    pause
    exit
)

REM Cheki kama port 9000 iko tayari
:wait_loop
echo Checking if PHP-CGI is ready...
powershell -command "(New-Object Net.Sockets.TcpClient).Connect('127.0.0.1', 9000)" 2>nul
if %errorlevel% neq 0 (
    timeout /t 2 >nul
    goto wait_loop
)

echo PHP-CGI is ready.
echo Starting Nginx...

IF EXIST "C:\nginx\nginx.exe" (
    start "" "C:\nginx\nginx.exe"
) ELSE (
    echo Nginx executable not found!
    pause
    exit
)

pause
