#!/bin/bash

# PostgreSQL connection configuration
CONTAINER_NAME="dat107-postgres"

# Connect to PostgreSQL database
echo "Connecting to container 'CONTAINER_NAME' ..."
docker exec -it $CONTAINER_NAME /bin/bash

