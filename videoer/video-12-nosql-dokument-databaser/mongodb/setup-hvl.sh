#!/usr/bin/env bash
# setup-teacher.sh - Create teacher collection with sample data in MongoDB
set -euo pipefail

CONTAINER_NAME="mongodb"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JS_FILE="${SCRIPT_DIR}/setup-hvl.js"
MAX_WAIT=30
WAIT_INTERVAL=2

echo "Setting up teacher collection in MongoDB..."
echo ""

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

echo ""
echo "Executing setup script..."
echo ""

# Execute the JavaScript setup file
docker exec -i "${CONTAINER_NAME}" mongosh < "${JS_FILE}"

echo ""
echo "════════════════════════════════════════════════════════════"
echo "✓ Setup complete!"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "To query the data:"
echo "  ./mongosh.sh"
echo "  db.teacher.find()"
echo ""
echo "Or use:"
echo "  ./mongosh.sh hvl_db"
echo ""

