# Using penultimate stable Alpine (check current versions)
FROM alpine:3.18

# Install MariaDB and necessary tools
RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client \
    mariadb-server-utils \
    && rm -rf /var/cache/apk/*

# Create necessary directories
RUN mkdir -p /var/run/mysqld /var/lib/mysql /docker-entrypoint-initdb.d
RUN chown -R mysql:mysql /var/run/mysqld /var/lib/mysql

# Copy configuration and tools
COPY conf/mariadb.conf /etc/my.cnf.d/mariadb-server.cnf
COPY tools/init_db.sh /docker-entrypoint-initdb.d/

# Set permissions
RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh

# Expose MariaDB port
EXPOSE 3306

# Use the official MariaDB entrypoint
COPY tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["mysqld", "--user=mysql", "--console"]