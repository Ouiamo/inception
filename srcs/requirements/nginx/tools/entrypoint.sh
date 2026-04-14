#!/bin/sh

set -e

echo "=== NGINX ENTRYPOINT STARTED ==="


echo "Checking if WordPress is ready..."
while ! nc -z wordpress 9000; do
  echo "Waiting for WordPress php-fpm..."
  sleep 2
done

echo "WordPress is ready!"


echo "Testing NGINX configuration..."
nginx -t

echo "=== NGINX ENTRYPOINT COMPLETED ==="


exec "$@"
