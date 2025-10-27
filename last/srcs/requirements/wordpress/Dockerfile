FROM alpine:3.18

RUN apk update && apk add --no-cache \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-json \
    php81-curl \
    php81-dom \
    php81-exif \
    php81-fileinfo \
    php81-mbstring \
    php81-openssl \
    php81-xml \
    php81-zip \
    php81-phar \
    php81-session \
    php81-tokenizer \
    php81-redis \
    curl \
    mariadb-client

# Download WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create WordPress directory
RUN mkdir -p /var/www/html

WORKDIR /var/www/html

# Copy configuration files
COPY conf/wordpress.conf /etc/php81/php-fpm.d/www.conf
COPY tools/entrypoint.sh /usr/local/bin/

# Increase memory limit
RUN echo 'memory_limit = 256M' > /etc/php81/conf.d/99-custom.ini

# Make entrypoint executable
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

CMD ["/usr/local/bin/entrypoint.sh"]