#!/bin/bash

# MongoDB Database Startup Script for DAT107
# Dette scriptet starter en MongoDB database i Docker container

# Standardinnstillinger
CONTAINER_NAME="dat107-mongodb"
DB_NAME="dat107_db"
MONGODB_PORT="27017"
HOST_PORT="27017"
IMAGE_NAME="dat107-mongodb"

echo "=== DAT107 MongoDB Database Startup ==="
echo "Container navn: $CONTAINER_NAME"
echo "Database navn: $DB_NAME"
echo "Port: $HOST_PORT"
echo "Autentisering: Deaktivert (utviklingsmodus)"
echo ""

# Sjekk om container allerede kjører
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "⚠️  Container $CONTAINER_NAME kjører allerede!"
    echo "Tilkoblingsinformasjon:"
    echo "  Host: localhost"
    echo "  Port: $HOST_PORT"
    echo "  Database: $DB_NAME"
    echo "  Autentisering: Ingen"
    echo ""
    echo "For å koble til med mongo shell:"
    echo "  docker exec -it $CONTAINER_NAME mongosh $DB_NAME"
    echo ""
    echo "For å stoppe containeren: docker stop $CONTAINER_NAME"
    exit 0
fi

# Sjekk om container eksisterer men er stoppet
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "📦 Starter eksisterende container $CONTAINER_NAME..."
    docker start $CONTAINER_NAME
else
    echo "🔨 Bygger MongoDB Docker image..."
    docker build -t $IMAGE_NAME .
    
    if [ $? -ne 0 ]; then
        echo "❌ Feil ved bygging av Docker image"
        exit 1
    fi
    
    echo "🚀 Oppretter og starter ny MongoDB container..."
    
    # Opprett data directory for persistent storage
    mkdir -p ./mongodb-data
    
    # Kjør MongoDB container
    docker run -d \
        --name $CONTAINER_NAME \
        -p $HOST_PORT:$MONGODB_PORT \
        -v "$(pwd)/mongodb-data:/data/db" \
        -e MONGO_INITDB_DATABASE=$DB_NAME \
        $IMAGE_NAME
fi

# Vent til database er klar
echo "⏳ Venter på at database blir klar..."
sleep 5

# Test tilkobling
for i in {1..30}; do
    if docker exec $CONTAINER_NAME mongosh --eval "db.runCommand('ping')" > /dev/null 2>&1; then
        echo "✅ MongoDB database er klar!"
        break
    fi
    echo "   Venter... ($i/30)"
    sleep 1
done

echo ""
echo "🎉 MongoDB database kjører nå!"
echo ""
echo "📋 Tilkoblingsinformasjon:"
echo "  Host: localhost"
echo "  Port: $HOST_PORT"
echo "  Database: $DB_NAME"
echo "  Connection String: mongodb://localhost:$HOST_PORT/$DB_NAME"
echo "  Autentisering: Ingen (utviklingsmodus)"
echo ""
echo "🔧 Nyttige kommandoer:"
echo "  Koble til med mongosh:  docker exec -it $CONTAINER_NAME mongosh $DB_NAME"
echo "  Se container logs:      docker logs $CONTAINER_NAME"
echo "  Stopp database:         docker stop $CONTAINER_NAME"
echo "  Fjern container:        docker rm $CONTAINER_NAME"
echo "  Fjern data (ADVARSEL):  rm -rf ./mongodb-data"
echo ""
echo "📚 Eksempel MongoDB kommandoer:"
echo "  db.collection.insertOne({name: 'test', value: 123})"
echo "  db.collection.find()"
echo "  show collections"
echo "  db.stats()"
echo ""
echo "🌐 For GUI-tilgang kan du bruke:"
echo "  - MongoDB Compass (https://www.mongodb.com/products/compass)"
echo "  - Robo 3T (https://robomongo.org/)"
echo "  - VS Code MongoDB extensions"