# Use PostgreSQL 15 Alpine as base image
FROM postgres:15-alpine

# Set environment variables for database initialization
ENV POSTGRES_DB=dat107_db
ENV POSTGRES_USER=dat107_user
ENV POSTGRES_PASSWORD=dat107_password

# Expose PostgreSQL port
EXPOSE 5432

# The postgres image already has VOLUME defined for /var/lib/postgresql/data
# Health check to ensure database is ready
HEALTHCHECK --interval=5s --timeout=5s --retries=30 --start-period=10s \
    CMD pg_isready -U dat107_user -d dat107_db || exit 1

# The default command from the base image will start PostgreSQL
# CMD ["postgres"]

