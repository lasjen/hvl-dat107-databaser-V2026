#!/usr/bin/env bash
# run-cql.sh - Execute CQL commands against Cassandra database
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

# Function to wait for Cassandra to be ready
wait_for_cassandra() {
    echo "Checking if Cassandra is ready..."
    local elapsed=0
    while [ $elapsed -lt $MAX_WAIT ]; do
        if docker exec "${CONTAINER_NAME}" cqlsh -e "SELECT cluster_name FROM system.local" &>/dev/null; then
            echo "✓ Cassandra is ready!"
            return 0
        fi
        echo "Waiting for Cassandra to start... (${elapsed}s/${MAX_WAIT}s)"
        sleep $WAIT_INTERVAL
        elapsed=$((elapsed + WAIT_INTERVAL))
    done

    echo "Error: Cassandra did not become ready within ${MAX_WAIT} seconds."
    echo "Check logs with: docker-compose logs cassandra"
    return 1
}

# Function to show usage
usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Options:
    -c, --command "CQL"     Execute a CQL command
    -f, --file FILE         Execute CQL commands from a file
    -k, --keyspace NAME     Use specified keyspace
    -h, --help              Show this help message

Examples:
    $0 -c "DESCRIBE KEYSPACES;"
    $0 -f schema.cql
    $0 -k mykeyspace -c "SELECT * FROM users;"
    $0  # Interactive mode (opens cqlsh)

EOF
    exit 0
}

# Parse arguments
COMMAND=""
FILE=""
KEYSPACE=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--command)
            COMMAND="$2"
            shift 2
            ;;
        -f|--file)
            FILE="$2"
            shift 2
            ;;
        -k|--keyspace)
            KEYSPACE="$2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# Wait for Cassandra to be ready
if ! wait_for_cassandra; then
    exit 1
fi

echo ""

# Build cqlsh command
CQLSH_CMD="cqlsh ${HOST}"

if [[ -n "${KEYSPACE}" ]]; then
    CQLSH_CMD="${CQLSH_CMD} -k ${KEYSPACE}"
fi

# Execute based on mode
if [[ -n "${COMMAND}" ]]; then
    # Execute single command
    docker exec -i "${CONTAINER_NAME}" ${CQLSH_CMD} -e "${COMMAND}"
elif [[ -n "${FILE}" ]]; then
    # Execute from file
    if [[ ! -f "${FILE}" ]]; then
        echo "Error: File '${FILE}' not found."
        exit 1
    fi
    echo "Executing CQL from file: ${FILE}"
    docker exec -i "${CONTAINER_NAME}" ${CQLSH_CMD} < "${FILE}"
else
    # Interactive mode
    echo "Opening interactive CQL shell..."
    echo "To exit, type: exit or quit"
    echo ""
    docker exec -it "${CONTAINER_NAME}" ${CQLSH_CMD}
fi

