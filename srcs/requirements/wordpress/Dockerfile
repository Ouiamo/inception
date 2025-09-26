# Use the Debian Bullseye image as a base
FROM debian:bullseye

# Set environment variable to make package installations non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages for WordPress and PHP-FPM
RUN apt-get update -y && \
    apt-get install -y php7.4-fpm php7.4-mysql curl && \
    rm -rf /var/lib/apt/lists/*

# Create a directory to hold the WordPress files
RUN mkdir -p /var/www/html

# Create the directory for the PHP-FPM PID file
RUN mkdir -p /run/php

# Copy the WordPress setup script into the container
COPY ./tools/init_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_wp.sh

# Expose port 9000, which is the default for PHP-FPM
EXPOSE 9000

# Set the command to run when the container starts
CMD ["init_wp.sh"]