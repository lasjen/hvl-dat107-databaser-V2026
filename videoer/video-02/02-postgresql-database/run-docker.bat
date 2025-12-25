@echo off
REM Stop and remove existing container if it exists
echo Stopping and removing existing container (if any)...
docker stop dat107-postgres 2>nul
docker rm dat107-postgres 2>nul

REM Run the PostgreSQL container
echo Starting PostgreSQL container...
docker run -d ^
  --name dat107-postgres ^
  -p 5432:5432 ^
  -v "%cd%/postgres-data:/var/lib/postgresql/data" ^
  --restart unless-stopped ^
  dat107-postgres:latest

if %ERRORLEVEL% EQU 0 (
    echo PostgreSQL container started successfully!
    echo.
    echo Container name: dat107-postgres
    echo Port: 5432
    echo Database: dat107_db
    echo User: dat107_user
    echo Password: dat107_password
    echo.
    echo To view logs:
    echo   docker logs dat107-postgres
    echo.
    echo To stop the container:
    echo   docker stop dat107-postgres
) else (
    echo Failed to start container!
    exit /b 1
)

