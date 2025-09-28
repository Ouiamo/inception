# Using penultimate stable Alpine
FROM alpine:3.18

# Install PHP, php-fpm, and necessary extensions
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
    php81-xmlreader \
    php81-zip \
    php81-gd \
    php81-intl \
    php81-phar \
    php81-iconv \
    curl \
    mariadb-client \
    openssl \
    && rm -rf /var/cache/apk/*

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Create WordPress directory
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

# Copy configuration and tools
COPY conf/wordpress.conf /etc/php81/php-fpm.d/www.conf
COPY tools/entrypoint.sh /usr/local/bin/

# Create custom PHP configuration with higher memory limit
RUN echo 'memory_limit = 256M' > /etc/php81/conf.d/99-custom.ini

# Set permissions
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose php-fpm port (usually 9000)
EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["php-fpm81", "-F"]