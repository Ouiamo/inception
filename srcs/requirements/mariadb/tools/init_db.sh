#!/bin/bash
set -e

# Temporary SQL file
TEMP_FILE=/tmp/temp_db_setup.sql

# If the DB is not initialized yet
if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
    echo "Initializing database..."

    cat <<EOF > "$TEMP_FILE"
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    # Run SQL setup in bootstrap mode
    mysqld --init-file="$TEMP_FILE" --user=mysql --bootstrap
fi

# Start MariaDB in foreground
exec mysqld_safe
