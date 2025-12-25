@echo off
REM Build the Docker image
echo Building PostgreSQL Docker image...
docker build -t dat107-postgres:latest .

if %ERRORLEVEL% EQU 0 (
    echo Build successful!
    echo.
    echo To run the container, use:
    echo   run-docker.bat
) else (
    echo Build failed!
    exit /b 1
)

