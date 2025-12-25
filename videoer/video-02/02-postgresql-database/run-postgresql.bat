@echo off
REM PostgreSQL Database Startup Script for DAT107 (Windows)
REM Dette scriptet starter en PostgreSQL database i Docker container

REM Standardinnstillinger
set CONTAINER_NAME=dat107-postgres
set DB_NAME=dat107_db
set DB_USER=dat107_user
set DB_PASSWORD=dat107_password
set POSTGRES_PORT=5432
set HOST_PORT=5432
set POSTGRES_VERSION=15-alpine

echo === DAT107 PostgreSQL Database Startup ===
echo Container navn: %CONTAINER_NAME%
echo Database navn: %DB_NAME%
echo Bruker: %DB_USER%
echo Port: %HOST_PORT%
echo PostgreSQL versjon: %POSTGRES_VERSION%
echo.

REM Sjekk om container allerede kjører
docker ps -q -f name=%CONTAINER_NAME% > nul 2>&1
if %errorlevel% equ 0 (
    for /f %%i in ('docker ps -q -f name=%CONTAINER_NAME%') do (
        if not "%%i"=="" (
            echo ⚠️  Container %CONTAINER_NAME% kjører allerede!
            echo Tilkoblingsinformasjon:
            echo   Host: localhost
            echo   Port: %HOST_PORT%
            echo   Database: %DB_NAME%
            echo   Bruker: %DB_USER%
            echo   Passord: %DB_PASSWORD%
            echo.
            echo For å koble til med psql:
            echo   docker exec -it %CONTAINER_NAME% psql -U %DB_USER% -d %DB_NAME%
            echo.
            echo For å stoppe containeren: docker stop %CONTAINER_NAME%
            goto :end
        )
    )
)

REM Sjekk om container eksisterer men er stoppet
docker ps -aq -f name=%CONTAINER_NAME% > nul 2>&1
if %errorlevel% equ 0 (
    for /f %%i in ('docker ps -aq -f name=%CONTAINER_NAME%') do (
        if not "%%i"=="" (
            echo 📦 Starter eksisterende container %CONTAINER_NAME%...
            docker start %CONTAINER_NAME%
            goto :wait_for_db
        )
    )
)

echo 🚀 Oppretter og starter ny PostgreSQL container...

REM Opprett data directory for persistent storage
if not exist postgres-data mkdir postgres-data

REM Kjør PostgreSQL container
docker run -d ^
    --name %CONTAINER_NAME% ^
    -e POSTGRES_DB=%DB_NAME% ^
    -e POSTGRES_USER=%DB_USER% ^
    -e POSTGRES_PASSWORD=%DB_PASSWORD% ^
    -p %HOST_PORT%:%POSTGRES_PORT% ^
    -v "%cd%/postgres-data:/var/lib/postgresql/data" ^
    postgres:%POSTGRES_VERSION%

:wait_for_db
REM Vent til database er klar
echo ⏳ Venter på at database blir klar...
timeout /t 5 /nobreak > nul

REM Test tilkobling
set /a counter=1
:check_loop
docker exec %CONTAINER_NAME% pg_isready -U %DB_USER% -d %DB_NAME% > nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ PostgreSQL database er klar!
    goto :success
)
echo    Venter... (%counter%/30)
set /a counter+=1
timeout /t 1 /nobreak > nul
if %counter% leq 30 goto :check_loop

echo ❌ Timeout - kunne ikke koble til database

:success
echo.
echo 🎉 PostgreSQL database kjører nå!
echo.
echo 📋 Tilkoblingsinformasjon:
echo   Host: localhost
echo   Port: %HOST_PORT%
echo   Database: %DB_NAME%
echo   Bruker: %DB_USER%
echo   Passord: %DB_PASSWORD%
echo.
echo 🔧 Nyttige kommandoer:
echo   Koble til med psql:     docker exec -it %CONTAINER_NAME% psql -U %DB_USER% -d %DB_NAME%
echo   Se container logs:     docker logs %CONTAINER_NAME%
echo   Stopp database:        docker stop %CONTAINER_NAME%
echo   Fjern container:       docker rm %CONTAINER_NAME%
echo   Fjern data (ADVARSEL): rmdir /s postgres-data
echo.
echo 🌐 For GUI-tilgang kan du bruke:
echo   - pgAdmin (https://www.pgadmin.org/)
echo   - DBeaver (https://dbeaver.io/)
echo   - VS Code PostgreSQL extensions

:end
pause