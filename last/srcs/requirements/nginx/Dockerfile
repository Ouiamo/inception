# Using penultimate stable Alpine
FROM alpine:3.18

# Install NGINX, openssl, and netcat (for health checks)
RUN apk update && apk add --no-cache \
    nginx \
    openssl \
    netcat-openbsd \
    && rm -rf /var/cache/apk/*

# Create necessary directories
RUN mkdir -p /var/run/nginx /var/log/nginx /etc/nginx/ssl

# Copy tools and configuration
COPY tools/entrypoint.sh /usr/local/bin/
COPY tools/generate-ssl.sh /usr/local/bin/
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Set execute permissions
RUN chmod +x /usr/local/bin/entrypoint.sh /usr/local/bin/generate-ssl.sh

# Generate SSL certificates
RUN /usr/local/bin/generate-ssl.sh

# Expose HTTPS port
EXPOSE 443

# Use entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]