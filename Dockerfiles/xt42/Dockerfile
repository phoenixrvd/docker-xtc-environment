FROM php:5.6-apache

# Install Linux-Deps.
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libxml2-dev \
    mysql-client \
    dnsutils

# Install PHP-Extensions
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd pdo iconv mcrypt mysqli mysql soap

# Install ioncube
COPY ioncube_loader_lin_5.6.so /usr/local/ioncube/ioncube_loader_lin_5.6.so

# Configure Apache
RUN echo ServerName localhost >> /etc/apache2/conf-enabled/docker-php.conf
RUN a2enmod rewrite
RUN a2enmod headers

# Install PHP-Settings
COPY php.ini /usr/local/etc/php/php.ini
COPY xt-init.sh /usr/bin/xt-init
RUN chmod +x /usr/bin/xt-init
