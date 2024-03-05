FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get --assume-yes install software-properties-common
RUN add-apt-repository ppa:ondrej/php

RUN apt-get update \
   && apt-get install -y \
   git \
   curl \
   nano \
   wget

RUN apt-get update \
   && apt-get install -y \
   php8.2 \
   php8.2-cli \
   php8.2-curl \
   php8.2-gd \
   php8.2-mysql \
   php8.2-xml \
   php8.2-zip \
   php8.2-intl \
   php8.2-mbstring \
   php8.2-amqp \
   php8.2-common

COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY apache2.conf /etc/apache2/apache2.conf

#Instalar composer
RUN mkdir /composer
RUN cd /composer && curl -sS https://getcomposer.org/installer | php
RUN cd /composer && mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

# Apache settings
RUN a2enmod rewrite

WORKDIR /var/www/html

CMD ["apachectl", "-D", "FOREGROUND"]
EXPOSE 80