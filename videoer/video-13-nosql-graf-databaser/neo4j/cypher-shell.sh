#!/usr/bin/env bash
# cypher-shell.sh - Connect to Neo4j using cypher-shell via Docker
set -euo pipefail

CONTAINER_NAME="neo4j"
MAX_WAIT=30
WAIT_INTERVAL=2

# Check if container is running
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Error: Neo4j container '${CONTAINER_NAME}' is not running."
    echo "Start it with: docker-compose up -d"
    exit 1
fi

# Wait for Neo4j to be ready
echo "Checking if Neo4j is ready..."
elapsed=0
while [ $elapsed -lt $MAX_WAIT ]; do
    if docker exec "${CONTAINER_NAME}" cypher-shell -a neo4j://localhost:7687 "RETURN 1;" &>/dev/null; then
        echo "✓ Neo4j is ready!"
        break
    fi
    echo "Waiting for Neo4j to start... (${elapsed}s/${MAX_WAIT}s)"
    sleep $WAIT_INTERVAL
    elapsed=$((elapsed + WAIT_INTERVAL))
done

if [ $elapsed -ge $MAX_WAIT ]; then
    echo "Error: Neo4j did not become ready within ${MAX_WAIT} seconds."
    echo "Check logs with: docker-compose logs neo4j"
    exit 1
fi

# Connect to cypher-shell
echo ""
echo "Connecting to Neo4j cypher-shell..."
echo "To exit, type: :exit"
echo ""

docker exec -it "${CONTAINER_NAME}" cypher-shell -a neo4j://localhost:7687

