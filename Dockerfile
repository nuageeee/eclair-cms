FROM php:8.3-apache

RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libwebp-dev libzip-dev \
 && docker-php-ext-configure gd --with-jpeg --with-webp \
 && docker-php-ext-install gd zip \
 && a2enmod rewrite headers remoteip \
 && sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf \
 && sed -i 's/%h/%a/g' /etc/apache2/apache2.conf \
 && printf 'RemoteIPHeader X-Forwarded-For\nRemoteIPTrustedProxy 10.0.0.0/8 172.16.0.0/12\n' > /etc/apache2/conf-enabled/remoteip.conf \
 && rm -rf /var/lib/apt/lists/*

COPY eclair/ /var/www/html/
RUN chown -R www-data:www-data /var/www/html
