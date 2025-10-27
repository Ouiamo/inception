#!/bin/sh

set -e

echo "=== NGINX ENTRYPOINT STARTED ==="

# Wait for WordPress to be ready
echo "Checking if WordPress is ready..."
while ! nc -z wordpress 9000; do
  echo "Waiting for WordPress php-fpm..."
  sleep 2
done

echo "WordPress is ready!"

# Test NGINX configuration
echo "Testing NGINX configuration..."
nginx -t

echo "=== NGINX ENTRYPOINT COMPLETED ==="

# Start NGINX
exec "$@"
