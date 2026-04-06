@echo off

REM PostgreSQL connection configuration
set CONTAINER_NAME=dat107-postgres
set DB_USER=dat107
set DB_NAME=dat107_db

REM Connect to PostgreSQL database
echo Connecting to PostgreSQL database '%DB_NAME%' as user '%DB_USER%'...
docker exec -it %CONTAINER_NAME% psql -U %DB_USER% -d %DB_NAME%
