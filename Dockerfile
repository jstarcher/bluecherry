FROM ubuntu:16.04
MAINTAINER jstarcher@gmail.com

ENV DEBIAN_FRONTEND noninteractive
ENV MYSQL_ADMIN_LOGIN root
ENV MYSQL_ADMIN_PASSWORD root
ENV user root
ENV password root
ENV dbname bluecherry

COPY .my.cnf /root/.my.cnf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN { \
        echo mysql-community-server mysql-community-server/data-dir select ''; \
        echo mysql-community-server mysql-community-server/root-pass password ''; \
        echo mysql-community-server mysql-community-server/re-root-pass password ''; \
        echo mysql-community-server mysql-community-server/remove-test-db select false; \
    } | debconf-set-selections && \
    apt-get update && \
    apt-get install -y supervisor wget && \
    wget -q http://ubuntu.bluecherrydvr.com/key/bluecherry.asc -O- | apt-key add - && \
    wget --output-document=/etc/apt/sources.list.d/bluecherry-unstable-xenial.list http://unstable.bluecherrydvr.com/sources.list.d/bluecherry-xenial.list && \
    apt-get update && \
    apt-get install -y bluecherry && \
    mkdir /var/log/supervisor

EXPOSE 80
CMD ["/usr/bin/supervisord"]
