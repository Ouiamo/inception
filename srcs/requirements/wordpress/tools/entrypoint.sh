#!/bin/sh

set -e

echo "=== WORDPRESS ENTRYPOINT STARTED ==="


echo "Waiting for MariaDB to be ready..."
while ! nc -z mariadb 3306; do
  sleep 1
done
echo "✅ MariaDB is ready!"


if [ ! -f wp-config.php ]; then
    echo "Installing WordPress..."
    

    wp core download --allow-root
    

    wp config create \
        --dbname=$DB_NAME \
        --dbuser=$DB_USER \
        --dbpass=$DB_PASSWORD \
        --dbhost=$DB_HOST:$DB_PORT \
        --allow-root
    

    wp core install \
        --url=$DOMAIN_NAME \
        --title="My WordPress Site" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --allow-root
    
    echo "✅ WordPress installed successfully!"
else
    echo "WordPress is already installed."
fi

echo "=== WORDPRESS ENTRYPOINT COMPLETED ==="

exec php-fpm81 -F
