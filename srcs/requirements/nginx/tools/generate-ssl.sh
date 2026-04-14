#!/bin/sh

set -e

DOMAIN="oaoulad-.42.fr"
SSL_DIR="/etc/nginx/ssl"

echo "Generating SSL certificates for $DOMAIN..."


mkdir -p $SSL_DIR


openssl req -newkey rsa:4096 \
            -x509 \
            -sha256 \
            -days 365 \
            -nodes \
            -out $SSL_DIR/$DOMAIN.crt \
            -keyout $SSL_DIR/$DOMAIN.key \
            -subj "/C=MA/ST=KHOURIBGA/L=KHOURIBGA/O=1337/OU=42/CN=$DOMAIN"


chmod 600 $SSL_DIR/$DOMAIN.key
chmod 644 $SSL_DIR/$DOMAIN.crt

echo "SSL certificates generated successfully!"
