FROM alpine:3.18


RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client \
    mariadb-server-utils \
    && rm -rf /var/cache/apk/*


RUN mkdir -p /var/run/mysqld /var/lib/mysql /docker-entrypoint-initdb.d
RUN chown -R mysql:mysql /var/run/mysqld /var/lib/mysql


COPY conf/mariadb.conf /etc/my.cnf.d/mariadb-server.cnf
COPY tools/init_db.sh /docker-entrypoint-initdb.d/


RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh


EXPOSE 3306


COPY tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["mysqld", "--user=mysql", "--console"]