FROM debian:bullseye

# Install MariaDB
RUN apt-get update -y && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Copy the new configuration file and the startup script
COPY ./tools/init_db.sh /usr/local/bin/
COPY ./conf/mariadb.cnf /etc/mysql/conf.d/

# Correct permissions for the configuration file
RUN chown mysql:mysql /etc/mysql/conf.d/mariadb.cnf && \
    chmod 644 /etc/mysql/conf.d/mariadb.cnf

# Make the startup script executable
RUN chmod +x /usr/local/bin/init_db.sh

# This is the entry point that Docker will run
CMD ["/usr/local/bin/init_db.sh"]