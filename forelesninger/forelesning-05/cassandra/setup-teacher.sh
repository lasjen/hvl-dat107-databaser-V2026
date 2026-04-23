#!/usr/bin/env bash
# setup-teacher.sh - Create keyspace and teacher table with sample data
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CQL_FILE="${SCRIPT_DIR}/create-teacher-table.cql"

echo "Setting up teacher table in Cassandra..."
echo ""

# Execute the CQL script using run-cql.sh
"${SCRIPT_DIR}/run-cql.sh" -f "${CQL_FILE}"

echo ""
echo "✓ Teacher table created successfully!"
echo ""
echo "To query the data, run:"
echo "  ./run-cql.sh -k hvl_db -c \"SELECT * FROM teacher;\""
echo ""
echo "Or open interactive shell:"
echo "  ./cqlsh.sh"
echo "  USE hvl_db;"
echo "  SELECT * FROM teacher;"

