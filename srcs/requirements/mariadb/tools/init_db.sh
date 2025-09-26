#!/bin/bash

# This script sets up the MariaDB database and then starts the MariaDB server.
# It uses MariaDB's standard environment variables for initialization.

# Create the SQL commands to set up the database and user.
echo "Creating initial SQL script..."
cat <<EOF > /tmp/temp_db_setup.sql
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Use mysqld_safe to start the server. This is a wrapper script that ensures
# a clean shutdown and handles restarts. We pass the init-file to it.
echo "Starting MariaDB service..."
mysqld_safe --init-file=/tmp/temp_db_setup.sql