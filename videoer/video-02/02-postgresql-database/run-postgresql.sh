#!/bin/bash

# PostgreSQL Database Startup Script for DAT107
# Dette scriptet starter en PostgreSQL database i Docker container

# Standardinnstillinger
CONTAINER_NAME="dat107-postgres"
DB_NAME="dat107_db"
DB_USER="dat107_user"
DB_PASSWORD="dat107_password"
POSTGRES_PORT="5432"
HOST_PORT="5432"
POSTGRES_VERSION="15-alpine"

echo "=== DAT107 PostgreSQL Database Startup ==="
echo "Container navn: $CONTAINER_NAME"
echo "Database navn: $DB_NAME"
echo "Bruker: $DB_USER"
echo "Port: $HOST_PORT"
echo "PostgreSQL versjon: $POSTGRES_VERSION"
echo ""

# Sjekk om container allerede kjører
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "⚠️  Container $CONTAINER_NAME kjører allerede!"
    echo "Tilkoblingsinformasjon:"
    echo "  Host: localhost"
    echo "  Port: $HOST_PORT" 
    echo "  Database: $DB_NAME"
    echo "  Bruker: $DB_USER"
    echo "  Passord: $DB_PASSWORD"
    echo ""
    echo "For å koble til med psql:"
    echo "  docker exec -it $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME"
    echo ""
    echo "For å stoppe containeren: docker stop $CONTAINER_NAME"
    exit 0
fi

# Sjekk om container eksisterer men er stoppet
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "📦 Starter eksisterende container $CONTAINER_NAME..."
    docker start $CONTAINER_NAME
else
    echo "🚀 Oppretter og starter ny PostgreSQL container..."
    
    # Opprett data directory for persistent storage
    mkdir -p ./postgres-data
    
    # Kjør PostgreSQL container
    docker run -d \
        --name $CONTAINER_NAME \
        -e POSTGRES_DB=$DB_NAME \
        -e POSTGRES_USER=$DB_USER \
        -e POSTGRES_PASSWORD=$DB_PASSWORD \
        -p $HOST_PORT:$POSTGRES_PORT \
        -v "$(pwd)/postgres-data:/var/lib/postgresql/data" \
        postgres:$POSTGRES_VERSION
fi

# Vent til database er klar
echo "⏳ Venter på at database blir klar..."
sleep 5

# Test tilkobling
for i in {1..30}; do
    if docker exec $CONTAINER_NAME pg_isready -U $DB_USER -d $DB_NAME > /dev/null 2>&1; then
        echo "✅ PostgreSQL database er klar!"
        break
    fi
    echo "   Venter... ($i/30)"
    sleep 1
done

echo ""
echo "🎉 PostgreSQL database kjører nå!"
echo ""
echo "📋 Tilkoblingsinformasjon:"
echo "  Host: localhost"
echo "  Port: $HOST_PORT"
echo "  Database: $DB_NAME"
echo "  Bruker: $DB_USER"
echo "  Passord: $DB_PASSWORD"
echo ""
echo "🔧 Nyttige kommandoer:"
echo "  Koble til med psql:     docker exec -it $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME"
echo "  Se container logs:     docker logs $CONTAINER_NAME"
echo "  Stopp database:        docker stop $CONTAINER_NAME"
echo "  Fjern container:       docker rm $CONTAINER_NAME"
echo "  Fjern data (ADVARSEL): rm -rf ./postgres-data"
echo ""
echo "🌐 For GUI-tilgang kan du bruke:"
echo "  - pgAdmin (https://www.pgadmin.org/)"
echo "  - DBeaver (https://dbeaver.io/)"
echo "  - VS Code PostgreSQL extensions"