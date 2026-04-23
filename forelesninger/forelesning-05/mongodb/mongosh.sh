#!/bin/bash

# Start mongosh i MongoDB Docker container
docker exec -it dat107-mongodb mongosh mongodb://localhost:27017/dat107_db

