#!/bin/bash

# PostgreSQL connection configuration
CONTAINER_NAME="dat107-postgres"
DB_USER="dat107"
DB_NAME="dat107_db"

# Connect to PostgreSQL database
echo "Connecting to PostgreSQL database '$DB_NAME' as user '$DB_USER'..."
docker exec -it $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME

