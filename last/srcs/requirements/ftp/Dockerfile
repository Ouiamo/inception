FROM alpine:3.18

# Update and install vsftpd with specific versions
RUN apk update && apk upgrade && \
    apk add --no-cache \
    vsftpd \
    openssl

# Create user and directories
RUN adduser -D -h /home/ftp/user -s /bin/false user && \
    mkdir -p /var/run/vsftpd/empty && \
    mkdir -p /home/ftp/user/files && \
    chown -R user:user /home/ftp/user && \
    chmod 755 /home/ftp/user

COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY tools/entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 21 20

CMD ["/usr/local/bin/entrypoint.sh"]