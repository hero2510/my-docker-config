FROM php:7.0-apache
MAINTAINER Fernando Mayo <fernando@tutum.co>

# Install base packages
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libldap2-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt pdo_mysql \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && pecl channel-update pecl.php.net \
    && pecl install apcu \
    && docker-php-ext-enable apcu

ENV ALLOW_OVERRIDE **False**
ENV APACHE_USER **False**
ENV APACHE_UID **False**

# Add image configuration and scripts
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# Configure /www folder with sample app
RUN mkdir -p /www && rm -fr /var/www/html && ln -s /www /var/www/html

EXPOSE 80
WORKDIR /www
CMD ["/run.sh"]