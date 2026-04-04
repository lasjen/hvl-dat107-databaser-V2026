@echo off

REM PostgreSQL connection configuration
set CONTAINER_NAME=dat107-postgres

REM Connect to PostgreSQL database
echo Connecting to container '%CONTAINER_NAME%' ...
docker exec -it %CONTAINER_NAME% /bin/bash
