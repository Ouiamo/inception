#!/bin/sh

set -e


if [ -z "$(ls -A /var/lib/mysql)" ]; then
    echo "Initializing MariaDB database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi


if [ -d "/docker-entrypoint-initdb.d" ]; then
    for f in /docker-entrypoint-initdb.d/*; do
        case "$f" in
            *.sh)  echo "Running $f"; . "$f" ;;
            *.sql) echo "Running $f"; mysql < "$f" ;;
        esac
    done
fi


exec "$@"