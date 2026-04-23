# Cassandra Docker Setup

This directory contains a Docker Compose setup for running a single-node Apache Cassandra database.

## Quick Start

### 1. Start Cassandra

```bash
docker-compose up -d
```

### 2. Wait for Cassandra to be ready

```bash
# Check logs
docker-compose logs -f cassandra

# Or check health status
docker-compose ps
```

Cassandra typically takes 30-60 seconds to fully start.

### 3. Connect to Cassandra

You can use the provided scripts to interact with Cassandra:

#### Simple CQL Shell (Interactive)

```bash
./cqlsh.sh
```

#### Advanced CQL Runner

```bash
# Interactive mode
./run-cql.sh

# Execute a single command
./run-cql.sh -c "DESCRIBE KEYSPACES;"

# Execute from a file
./run-cql.sh -f schema.cql

# Use a specific keyspace
./run-cql.sh -k mykeyspace -c "SELECT * FROM users;"

# Help
./run-cql.sh --help
```

## Example CQL Commands

Once connected to cqlsh, you can run:

```cql
-- Create a keyspace
CREATE KEYSPACE IF NOT EXISTS test_keyspace
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

-- Use the keyspace
USE test_keyspace;

-- Create a table
CREATE TABLE IF NOT EXISTS users (
    user_id UUID PRIMARY KEY,
    username TEXT,
    email TEXT,
    created_at TIMESTAMP
);

-- Insert data
INSERT INTO users (user_id, username, email, created_at)
VALUES (uuid(), 'john_doe', 'john@example.com', toTimestamp(now()));

-- Query data
SELECT * FROM users;

-- Describe cluster
DESCRIBE CLUSTER;

-- List keyspaces
DESCRIBE KEYSPACES;

-- Exit
exit;
```

## Quick Setup: Teacher Table Example

A ready-to-use example is provided with a teacher table:

### Run the setup script

```bash
chmod +x setup-teacher.sh
./setup-teacher.sh
```

This creates:
- **Keyspace**: `hvl_db` (SimpleStrategy, replication_factor: 1)
- **Table**: `teacher` with columns:
  - `id` (UUID, PRIMARY KEY)
  - `fornavn` (TEXT)
  - `etternavn` (TEXT)
- **Sample data**: 8 teachers

### Query the teacher table

```bash
# Using the run-cql script
./run-cql.sh -k hvl_db -c "SELECT * FROM teacher;"

# Or interactively
./cqlsh.sh
# Then in cqlsh:
USE hvl_db;
SELECT * FROM teacher;
```

### Manual setup

You can also run the CQL file directly:
```bash
./run-cql.sh -f create-teacher-table.cql
```

## Ports

- **9042**: CQL native transport port (main client connection)
- **7199**: JMX monitoring port
- **9160**: Thrift client API (legacy)

## Configuration

The Cassandra instance is configured with:

- **Cluster Name**: TestCluster
- **Datacenter**: datacenter1
- **Rack**: rack1
- **Max Heap Size**: 512M
- **New Heap Size**: 100M

## Data Persistence

Data is persisted in the Docker volume `cassandra-data`. To remove all data:

```bash
docker-compose down -v
```

## Troubleshooting

### Container won't start

Check logs:
```bash
docker-compose logs cassandra
```

### Cluster name mismatch error

If you see an error like:
```
Saved cluster name Test Cluster != configured name TestCluster
```

This means the data volume has an old cluster configuration. Fix by removing the volume and restarting:

```bash
docker-compose down -v
docker-compose up -d
```

**Note**: This will delete all existing data!

### Connection refused

Wait longer - Cassandra needs time to initialize. Check the health status:
```bash
docker exec cassandra-node1 nodetool status
```

### Reset everything

```bash
docker-compose down -v
docker-compose up -d
```

## Monitoring

### Check node status

```bash
docker exec cassandra-node1 nodetool status
```

### Check cluster info

```bash
docker exec cassandra-node1 nodetool info
```

### View ring information

```bash
docker exec cassandra-node1 nodetool ring
```

## Stop Cassandra

```bash
# Stop but keep data
docker-compose down

# Stop and remove data
docker-compose down -v
```

## Resources

- [Apache Cassandra Documentation](https://cassandra.apache.org/doc/latest/)
- [CQL Reference](https://cassandra.apache.org/doc/latest/cql/)
- [Docker Hub - Cassandra](https://hub.docker.com/_/cassandra)

