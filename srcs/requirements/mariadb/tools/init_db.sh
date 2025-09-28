#!/bin/sh

set -e

# Start MariaDB temporarily to run initialization
mysqld_safe --datadir='/var/lib/mysql' &

# Wait for MariaDB to start
while ! mysqladmin ping --silent; do
    sleep 1
done

# Create database and users
mysql -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';"

# Create administrator user (non-admin named)
mysql -e "CREATE USER IF NOT EXISTS '${WP_ADMIN_USER}'@'%' IDENTIFIED BY '${WP_ADMIN_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${WP_ADMIN_USER}'@'%';"

mysql -e "FLUSH PRIVILEGES;"

# Stop the temporary MariaDB instance
mysqladmin shutdown