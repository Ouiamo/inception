FROM alpine:3.19

RUN apk update && apk add --no-cache redis

# Copy Redis configuration
COPY conf/redis.conf /etc/redis.conf

# Create Redis directory and set permissions
RUN mkdir -p /var/lib/redis && \
    chown -R redis:redis /var/lib/redis

EXPOSE 6379

CMD ["redis-server", "/etc/redis.conf"]