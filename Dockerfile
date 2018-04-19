FROM debian:stretch-slim
MAINTAINER BeN
ENV DEBIAN_FRONTEND noninteractive
RUN mkdir -p /var/cache/apt/archives/
RUN apt-get clean && apt-get update && apt-get -y upgrade

RUN apt-get install -y \
    curl \
    php-dev \
    php-cli \
    php-mysql \
    php-intl \
    php-curl \
    php-fpm \
    php-pear \
    php-gd \
    nginx

RUN apt-get clean all

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.0/fpm/php.ini
RUN sed -i "s/display_errors = Off/display_errors = On/" /etc/php/7.0/fpm/php.ini
RUN sed -i "s/;listen.allowed_clients = 127.0.0.1/listen.allowed_clients = 0.0.0.0/" /etc/php/7.0/fpm/pool.d/www.conf

RUN usermod -a -G adm www-data

EXPOSE 80

COPY conf/default /etc/nginx/sites-available/default
RUN mkdir /www

COPY conf/start.sh /root/start.sh
RUN chmod u+x /root/start.sh
