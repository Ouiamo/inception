FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Install PHP, MySQL support, curl, wget, unzip, and wp-cli
RUN apt-get update -y && \
    apt-get install -y php-cli php-fpm php-mysql curl wget unzip less && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    rm -rf /var/lib/apt/lists/*

# Copy entrypoint
COPY tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/www/html

ENTRYPOINT ["entrypoint.sh"]
