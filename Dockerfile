FROM alpine:3.6


ENV MARIADB_VER 10.1.26-r0


RUN set -xe && \
    apk add --no-cache \
        bash \
        ca-certificates \
        make \
        mariadb=${MARIADB_VER} \
        mariadb-client \
        pwgen \
        tzdata \
        wget 



RUN mkdir -p /var/run/mysqld && mkdir -p /var/lib/mysql
RUN chown -R mysql:mysql /var/run/mysqld && chown -R mysql:mysql /var/lib/mysql

RUN mkdir /docker-entrypoint-initdb.d

ADD my.cnf /etc/mysql/my.cnf

WORKDIR  mkdir /etc/mysql/conf.d
COPY docker-entrypoint.sh /

WORKDIR /var/lib/mysql
VOLUME /var/lib/mysql


EXPOSE 3306

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["mysqld"]
