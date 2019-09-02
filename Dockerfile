FROM alpine:3.5

LABEL maintainer="Balazs Nadasdi <balazs.nadasdi@cheppers.com>"

ENV PRIVATE_BIN_VERSION=1.3

RUN apk add --no-cache curl \
      php7 apache2 php7-apache2 \
      php7-json php7-zlib php7-gd && \
      mkdir /run/apache2

RUN rm -rf /var/www/localhost/htdocs/* && \
      curl -sLO https://github.com/PrivateBin/PrivateBin/archive/${PRIVATE_BIN_VERSION}.tar.gz && \
      tar zxf ${PRIVATE_BIN_VERSION}.tar.gz -C /var/www/localhost/htdocs --strip-components=1

WORKDIR /var/www/localhost/htdocs

RUN mv .htaccess.disabled .htaccess && \
      mkdir data && chown apache data

EXPOSE 80

ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
