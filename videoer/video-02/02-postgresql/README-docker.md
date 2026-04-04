# PostgreSQL Docker Setup

This directory shows how to run PostgreSQL locally by using Docker Compose.:

## Configuration

- **Database**: dat107_db
- **User**: dat107
- **Password**: dat107
- **Port**: 5432

## Prerequisites

The following installation is required go get started with Docker:
- **Docker**: Install Docker Desktop or Docker Engine

## Using Docker Compose 

```bash
# Start the database
cd videoer/video-02/02-postgresql
docker-compose up -d

# Stop the database
cd videoer/video-02/02-postgresql
docker-compose down
```

### Manual Commands

## Connecting to the Database

Use the provided connection script:

**Docker:**
```bash
./psql.sh
```

Or connect manually using psql:

**With Docker:**<br>
_Note! Since psql is running inside the container (and the database host) you do't need to specify the password or host._
```bash
docker exec -it dat107-postgres psql -U dat107_user -d dat107_db
```

## Useful Commands

**Docker:**
```bash
# View logs
docker logs dat107-postgres

# Follow logs in real-time
docker logs -f dat107-postgres

# Stop the container
docker stop dat107-postgres

# Start the container
docker start dat107-postgres

# Remove the container
docker rm dat107-postgres

# Remove the image
docker rmi dat107-postgres:latest
```


## Data Persistence

Database data is stored in the `postgres-data/` directory and persists between container restarts. This directory is excluded from version control via `.gitignore`.

## Health Check

The Dockerfile includes a health check that verifies the database is ready to accept connections every 5 seconds.

## Security Note

⚠️ **Warning**: The database credentials are hardcoded for development purposes. In production environments, use environment variables or Docker secrets to manage sensitive information.

