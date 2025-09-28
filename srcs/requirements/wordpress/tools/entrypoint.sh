#!/bin/sh

set -e

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
while ! mysqladmin ping -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" -p"$DB_PASSWORD" --silent; do
    sleep 2
done

echo "MariaDB is ready!"

# Check if WordPress is already installed
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Installing WordPress..."
    
    # Download WordPress
    wp core download --allow-root
    
    # Create wp-config.php
    wp config create \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="$DB_HOST:$DB_PORT" \
        --allow-root \
        --skip-check
    
    # Install WordPress
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root
    
    echo "WordPress installed successfully!"
else
    echo "WordPress is already installed."
fi

# Fix permissions
chown -R nobody:nobody /var/www/html

# Start php-fpm
exec "$@"