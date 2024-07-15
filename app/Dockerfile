FROM php:8.2-apache

RUN docker-php-ext-install pdo pdo_mysql && a2enmod rewrite

COPY index.php .htaccess /var/www/html/
COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf

EXPOSE 80
