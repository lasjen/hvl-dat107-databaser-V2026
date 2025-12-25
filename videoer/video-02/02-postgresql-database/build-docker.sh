#!/bin/bash

# Build the Docker image
echo "Building PostgreSQL Docker image..."
docker build -t dat107-postgres:latest .

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "Build successful!"
    echo ""
    echo "To run the container, use:"
    echo "  ./run-docker.sh"
else
    echo "Build failed!"
    exit 1
fi

