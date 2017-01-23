FROM ubuntu:16.04
MAINTAINER jstarcher@gmail.com

ENV DEBIAN_FRONTEND noninteractive
ENV MYSQL_ADMIN_LOGIN root
ENV MYSQL_ADMIN_PASSWORD root
ENV user root
ENV password root
ENV dbname bluecherry

RUN apt-get update && \
    apt-get install -y supervisor wget && \
    wget -q http://ubuntu.bluecherrydvr.com/key/bluecherry.asc -O- | apt-key add - && \
    wget --output-document=/etc/apt/sources.list.d/bluecherry-unstable-xenial.list http://unstable.bluecherrydvr.com/sources.list.d/bluecherry-xenial.list && \
    apt-get update && \
    apt-get install -y bluecherry && \
    mkdir /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]
