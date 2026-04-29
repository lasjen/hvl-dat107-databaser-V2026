#!/usr/bin/env bash
# mongosh.sh - Connect to MongoDB using mongosh via Docker
set -euo pipefail

CONTAINER_NAME="mongodb"
DB_NAME="hvl_db"
MAX_WAIT=30
WAIT_INTERVAL=2

# Check if container is running
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Error: MongoDB container '${CONTAINER_NAME}' is not running."
    echo "Start it with: docker-compose up -d"
    exit 1
fi

# Wait for MongoDB to be ready
echo "Checking if MongoDB is ready..."
elapsed=0
while [ $elapsed -lt $MAX_WAIT ]; do
    if docker exec "${CONTAINER_NAME}" mongosh --eval "db.adminCommand('ping')" --quiet &>/dev/null; then
        echo "✓ MongoDB is ready!"
        break
    fi
    echo "Waiting for MongoDB to start... (${elapsed}s/${MAX_WAIT}s)"
    sleep $WAIT_INTERVAL
    elapsed=$((elapsed + WAIT_INTERVAL))
done

if [ $elapsed -ge $MAX_WAIT ]; then
    echo "Error: MongoDB did not become ready within ${MAX_WAIT} seconds."
    echo "Check logs with: docker-compose logs mongodb"
    exit 1
fi

# Connect to MongoDB shell
echo ""
echo "Connecting to MongoDB shell..."
echo "Default database: ${DB_NAME}"
echo "To exit, type: exit or press Ctrl+D"
echo ""

# If database argument provided, use it
if [ $# -gt 0 ]; then
    DB_NAME="$1"
    echo "Using database: ${DB_NAME}"
    echo ""
fi

docker exec -it "${CONTAINER_NAME}" mongosh "${DB_NAME}"

