# MongoDB Database for DAT107
FROM mongo:7.0

# Opprett data directory
RUN mkdir -p /data/db

# Sett MongoDB til å kjøre uten autentisering
ENV MONGO_INITDB_DATABASE=dat107_db

# Eksponer standard MongoDB port
EXPOSE 27017

# Kjør MongoDB uten autentisering
CMD ["mongod", "--noauth", "--bind_ip_all"]