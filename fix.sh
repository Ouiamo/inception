#!/bin/bash

# Fix mariadb entrypoint filename
mv srcs/requirements/mariadb/tools/enterypoint.sh srcs/requirements/mariadb/tools/entrypoint.sh 2>/dev/null || true

# Set execute permissions
chmod +x srcs/requirements/mariadb/tools/*.sh
chmod +x srcs/requirements/wordpress/tools/*.sh

# Create .env file if it doesn't exist
if [ ! -f "srcs/.env" ]; then
    cat > srcs/.env << EOF
# Domain
DOMAIN_NAME=oaoulad-.42.fr

# Database
DB_NAME=wordpress
DB_USER=wp_user
DB_PASSWORD=wp_password
DB_ROOT_PASSWORD=root_password
DB_HOST=mariadb
DB_PORT=3306

# WordPress
WP_TITLE=My WordPress Site
WP_ADMIN_USER=superuser
WP_ADMIN_PASSWORD=admin_password
WP_ADMIN_EMAIL=admin@oaoulad-.42.fr

# Paths
WP_VOLUME=/home/oaoulad-/data/wordpress
DB_VOLUME=/home/oaoulad-/data/mariadb
EOF
    echo "Created srcs/.env file"
fi

echo "All fixes applied! Now run: make build"