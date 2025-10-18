FROM alpine:3.19

RUN apk update && apk add --no-cache \
    php81 \
    php81-session \
    php81-mysqli \
    php81-pdo \
    php81-pdo_mysql

# Create directory and download Adminer
RUN mkdir -p /var/www/html && \
    wget -O /var/www/html/index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php

WORKDIR /var/www/html

EXPOSE 8080

CMD ["php81", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
