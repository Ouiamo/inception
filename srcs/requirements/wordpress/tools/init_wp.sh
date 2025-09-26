#!/bin/bash

echo "Waiting for MariaDB to be ready..."
while ! mariadb -h mariadb -u$DB_USER -p$DB_PASSWORD -e "SHOW DATABASES;" > /dev/null 2>&1; do
    sleep 1
done
echo "MariaDB is ready!"

# Go to the WordPress directory
cd /var/www/html

# Check if WordPress is already downloaded to avoid re-downloading on restarts
if ! [ -e index.php ]; then
    # Download the WP-CLI tool
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    # Download the latest version of WordPress
    wp core download --allow-root
fi

# Create wp-config.php file using environment variables
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=mariadb --allow-root

# Install WordPress and create a user
wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

# Create an author user (optional but good for the project)
wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

# Change owner of the WordPress files to www-data, which is the user PHP-FPM runs as
chown -R www-data:www-data /var/www/html

# Set PHP-FPM to listen on TCP port 9000 instead of a Unix socket
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

# Start the PHP-FPM service in the foreground
/usr/sbin/php-fpm7.4 -F