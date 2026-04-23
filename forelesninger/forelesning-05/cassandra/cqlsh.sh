#!/usr/bin/env bash
# cqlsh.sh - Connect to Cassandra database using CQL shell via Docker
set -euo pipefail

CONTAINER_NAME="cassandra-node1"
HOST="cassandra"
MAX_WAIT=60
WAIT_INTERVAL=5

# Check if container is running
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Error: Cassandra container '${CONTAINER_NAME}' is not running."
    echo "Start it with: docker-compose up -d"
    exit 1
fi

# Wait for Cassandra to be ready
echo "Checking if Cassandra is ready..."
elapsed=0
while [ $elapsed -lt $MAX_WAIT ]; do
    if docker exec "${CONTAINER_NAME}" cqlsh -e "SELECT cluster_name FROM system.local" &>/dev/null; then
        echo "✓ Cassandra is ready!"
        break
    fi
    echo "Waiting for Cassandra to start... (${elapsed}s/${MAX_WAIT}s)"
    sleep $WAIT_INTERVAL
    elapsed=$((elapsed + WAIT_INTERVAL))
done

if [ $elapsed -ge $MAX_WAIT ]; then
    echo "Error: Cassandra did not become ready within ${MAX_WAIT} seconds."
    echo "Check logs with: docker-compose logs cassandra"
    exit 1
fi

# Connect to CQL shell
echo ""
echo "Connecting to Cassandra CQL shell..."
echo "To exit, type: exit or quit"
echo ""

docker exec -it "${CONTAINER_NAME}" cqlsh "${HOST}"

