# PostgreSQL Docker Setup

This directory contains a PostgreSQL database setup using Docker Compose for local development.

## Overview

- **Database Name**: `dat107_db`
- **Username**: `dat107`
- **Password**: `dat107`
- **Port**: `5432`
- **Container Name**: `dat107-postgres`

## Prerequisites

- **Docker**: Install Docker Desktop or Docker Engine
  - macOS: [Docker Desktop for Mac](https://docs.docker.com/desktop/mac/install/)
  - Windows: [Docker Desktop for Windows](https://docs.docker.com/desktop/windows/install/)
  - Linux: [Docker Engine](https://docs.docker.com/engine/install/)

## Quick Start

### Starting the Database

```bash
# Navigate to the directory
cd videoer/video-02/02-postgresql

# Start the database in detached mode
docker-compose up -d
```

### Stopping the Database

```bash
# Stop and remove containers
docker-compose down

# Stop and remove containers, volumes, and images
docker-compose down -v --rmi all
```

## Connecting to the Database

### Using the Connection Script

The easiest way to connect is using the provided script:

```bash
sh mongosh.sh   # Mac/Linux
connect.bat    # Windows
```

### Manual Connection

Connect manually using the PostgreSQL client inside the container:

```bash
docker exec -it dat107-postgres psql -U dat107 -d dat107_db
```

**Note**: Since `psql` runs inside the container where the database is hosted, you don't need to specify the password or host.

## Database Migration

Run SQL migration scripts to set up test tables and data:

```bash
# Run the migration script
./migrate-db.sh # Mac/Linux
migrate-db.bat  # Windows

# Or manually execute specific SQL files
docker exec -i dat107-postgres psql -U dat107 -d dat107_db < sql/ansatte.sql
docker exec -i dat107-postgres psql -U dat107 -d dat107_db < sql/hobbyhuset.sql
```

## Data Persistence

- Database data is stored in the `postgres-data/` directory
- Data persists between container restarts and removals
- This directory is excluded from version control via `.gitignore`
- To completely reset the database, remove this directory:
  ```bash
  docker-compose down -v
  rm -rf postgres-data/
  ```

## Additional Resources

- [PostgreSQL Official Documentation](https://www.postgresql.org/docs/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [PostgreSQL Docker Hub](https://hub.docker.com/_/postgres)

