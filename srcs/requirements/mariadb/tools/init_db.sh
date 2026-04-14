#!/bin/sh

set -e

mysqld_safe --datadir='/var/lib/mysql' &

while ! mysqladmin ping --silent; do
    sleep 1
done


mysql -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';"


mysql -e "CREATE USER IF NOT EXISTS '${WP_ADMIN_USER}'@'%' IDENTIFIED BY '${WP_ADMIN_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${WP_ADMIN_USER}'@'%';"

mysql -e "FLUSH PRIVILEGES;"

mysqladmin shutdown