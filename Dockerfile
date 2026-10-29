FROM php:8.3-apache

RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libwebp-dev libzip-dev \
 && docker-php-ext-configure gd --with-jpeg --with-webp \
 && docker-php-ext-install gd zip \
 && a2enmod rewrite headers \
 && sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf \
 && rm -rf /var/lib/apt/lists/*

COPY eclair/ /var/www/html/
RUN chown -R www-data:www-data /var/www/html
