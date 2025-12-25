#!/bin/bash

# Bygg Docker image
echo "Bygger Docker image..."
docker build -t enkel-webserver .

# Kjør container med volume mapping
echo "Starter container med volume mapping..."
docker run -d -p 8080:80 \
  -v "$(pwd):/usr/share/nginx/html:ro" \
  --name webserver \
  enkel-webserver

echo "Webserver er tilgjengelig på http://localhost:8080"
echo "For å stoppe containeren, kjør: docker stop webserver"
echo "For å fjerne containeren, kjør: docker rm webserver"