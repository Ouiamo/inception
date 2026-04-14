FROM alpine:3.18

RUN apk update && apk add --no-cache \
    nginx \
    openssl \
    netcat-openbsd \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /var/run/nginx /var/log/nginx /etc/nginx/ssl

COPY tools/entrypoint.sh /usr/local/bin/
COPY tools/generate-ssl.sh /usr/local/bin/
COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod +x /usr/local/bin/entrypoint.sh /usr/local/bin/generate-ssl.sh


RUN /usr/local/bin/generate-ssl.sh

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]