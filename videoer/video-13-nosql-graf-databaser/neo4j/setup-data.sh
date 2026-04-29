#!/usr/bin/env bash
# setup-data.sh - Load seed data into Neo4j database
set -euo pipefail

CONTAINER_NAME="neo4j"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_CYPHER_FILE="seed-data.cypher"
MAX_WAIT=60
WAIT_INTERVAL=5

# Check for command line argument
if [ $# -gt 0 ]; then
    CYPHER_FILENAME="$1"
else
    CYPHER_FILENAME="${DEFAULT_CYPHER_FILE}"
fi

CYPHER_FILE="${SCRIPT_DIR}/${CYPHER_FILENAME}"

# Check if cypher file exists
if [ ! -f "${CYPHER_FILE}" ]; then
    echo "Error: Cypher file not found: ${CYPHER_FILE}"
    echo "Usage: $0 [cypher-file]"
    echo "Example: $0 seed-venner.cypher"
    exit 1
fi

echo "Setting up Neo4j database with seed data from: ${CYPHER_FILENAME}"
echo ""

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

echo ""
echo "Loading seed data from: ${CYPHER_FILENAME}"
echo ""

# Execute the Cypher file
if docker exec -i "${CONTAINER_NAME}" cypher-shell -a neo4j://localhost:7687 < "${CYPHER_FILE}"; then
    echo ""
    echo "════════════════════════════════════════════════════════════"
    echo "✓ Seed data loaded successfully from: ${CYPHER_FILENAME}"
    echo "════════════════════════════════════════════════════════════"
    echo ""
    echo "Access Neo4j Browser: http://localhost:7474"
    echo ""
    echo "Example queries:"
    echo "  MATCH (n) RETURN n;"
    echo "  MATCH (n) RETURN n LIMIT 10;"
    echo ""
else
    echo ""
    echo "Error: Failed to load seed data from: ${CYPHER_FILENAME}"
    echo "Check the Cypher file for syntax errors."
    exit 1
fi

