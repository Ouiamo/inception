#!/bin/sh

set -e

echo "=== WORDPRESS ENTRYPOINT STARTED ==="

# Wait for MariaDB to be ready with timeout
echo "Waiting for MariaDB to be ready..."
timeout=60
while ! mysqladmin ping -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" -p"$DB_PASSWORD" --silent; do
    sleep 2
    timeout=$((timeout-2))
    if [ $timeout -le 0 ]; then
        echo "❌ ERROR: MariaDB connection timeout"
        exit 1
    fi
done

echo "✅ MariaDB is ready!"

# Check if WordPress is already installed (look for wp-config.php and check if DB has tables)
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Installing WordPress..."
    
    # Download WordPress directly using curl (more memory efficient)
    echo "Downloading WordPress using curl..."
    curl -o /tmp/wordpress.tar.gz -SL https://wordpress.org/latest.tar.gz
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1
    rm /tmp/wordpress.tar.gz
    
    # Create wp-config.php manually
    echo "Creating wp-config.php..."
    cat > /var/www/html/wp-config.php << EOF
<?php
define('DB_NAME', '${DB_NAME}');
define('DB_USER', '${DB_USER}');
define('DB_PASSWORD', '${DB_PASSWORD}');
define('DB_HOST', '${DB_HOST}:${DB_PORT}');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('AUTH_KEY',         '$(openssl rand -base64 48)');
define('SECURE_AUTH_KEY',  '$(openssl rand -base64 48)');
define('LOGGED_IN_KEY',    '$(openssl rand -base64 48)');
define('NONCE_KEY',        '$(openssl rand -base64 48)');
define('AUTH_SALT',        '$(openssl rand -base64 48)');
define('SECURE_AUTH_SALT', '$(openssl rand -base64 48)');
define('LOGGED_IN_SALT',   '$(openssl rand -base64 48)');
define('NONCE_SALT',       '$(openssl rand -base64 48)');

\$table_prefix = 'wp_';
define('WP_DEBUG', false);

if ( ! defined('ABSPATH') ) {
    define('ABSPATH', __DIR__ . '/');
}

require_once ABSPATH . 'wp-settings.php';
EOF
    
    # Install WordPress using WP-CLI
    echo "Running WordPress installation..."
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root
    
    echo "✅ WordPress installed successfully!"
else
    echo "WordPress files exist, checking if installation is complete..."
    
    # Check if WordPress is actually installed in the database
    if ! wp core is-installed --allow-root 2>/dev/null; then
        echo "WordPress files exist but installation is incomplete. Completing installation..."
        wp core install \
            --url="${DOMAIN_NAME}" \
            --title="${WP_TITLE}" \
            --admin_user="${WP_ADMIN_USER}" \
            --admin_password="${WP_ADMIN_PASSWORD}" \
            --admin_email="${WP_ADMIN_EMAIL}" \
            --allow-root
        echo "✅ WordPress installation completed!"
    else
        echo "WordPress is already fully installed."
    fi
fi

# Fix permissions
chown -R nobody:nobody /var/www/html
chmod -R 755 /var/www/html

echo "=== WORDPRESS ENTRYPOINT COMPLETED ==="

# Start php-fpm
exec "$@"