#!/bin/bash

# PostgreSQL connection configuration
CONTAINER_NAME="dat107-postgres"
DB_USER="dat107"
DB_NAME="dat107_db"
SQL_DIR="sql"

# Function to run SQL file
run_sql_file() {
    local sql_file=$1
    echo "Running SQL script: $sql_file..."
    docker exec -i $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME < "$sql_file"
    if [ $? -eq 0 ]; then
        echo "✓ Successfully executed $sql_file"
    else
        echo "✗ Error executing $sql_file"
        exit 1
    fi
}

# Main script
echo "Starting database migration..."
echo "================================"

# Run ansatte.sql
run_sql_file "${SQL_DIR}/ansatte.sql"

# Run hobbyhuset.sql
#run_sql_file "${SQL_DIR}/hobbyhuset.sql"

echo "================================"
echo "Database migration completed successfully!"
