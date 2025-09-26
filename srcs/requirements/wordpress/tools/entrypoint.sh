#!/bin/bash
set -e

# Wait for MariaDB to be ready
until mysqladmin ping -hmariadb -uroot -p"${DB_ROOT_PASSWORD}" --silent; do
  echo "Waiting for MariaDB..."
  sleep 2
done

echo "MariaDB is up - continuing..."


# Create database and user if they don't exist
mysql -h mariadb -uroot -p"${DB_ROOT_PASSWORD}" -e "
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
"

# Install WordPress if not installed
if [ ! -f wp-config.php ]; then
    wp core download --allow-root
    wp config create --allow-root \
        --dbname="${DB_NAME}" \
        --dbuser="${DB_USER}" \
        --dbpass="${DB_PASSWORD}" \
        --dbhost="mariadb"
    wp core install --allow-root \
        --url="${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email
fi

# Start PHP-FPM
exec php-fpm7.4 -F
