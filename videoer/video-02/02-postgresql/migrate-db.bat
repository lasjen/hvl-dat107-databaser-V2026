@echo off

REM PostgreSQL connection configuration
set CONTAINER_NAME=dat107-postgres
set DB_USER=dat107
set DB_NAME=dat107_db
set SQL_DIR=sql

echo Starting database migration...
echo ================================

REM Run ansatte.sql
echo Running SQL script: %SQL_DIR%\ansatte.sql...
docker exec -i %CONTAINER_NAME% psql -U %DB_USER% -d %DB_NAME% < "%SQL_DIR%\ansatte.sql"
if %ERRORLEVEL% neq 0 (
    echo Error executing %SQL_DIR%\ansatte.sql
    exit /b 1
)
echo Successfully executed %SQL_DIR%\ansatte.sql

REM Run hobbyhuset.sql
echo Running SQL script: %SQL_DIR%\hobbyhuset.sql...
docker exec -i %CONTAINER_NAME% psql -U %DB_USER% -d %DB_NAME% < "%SQL_DIR%\hobbyhuset.sql"
if %ERRORLEVEL% neq 0 (
    echo Error executing %SQL_DIR%\hobbyhuset.sql
    exit /b 1
)
echo Successfully executed %SQL_DIR%\hobbyhuset.sql

echo ================================
echo Database migration completed successfully!
