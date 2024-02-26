FROM php:8.2-fpm

WORKDIR /var/www/html

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git libzip-dev libpng-dev  \
    && docker-php-ext-install pcntl zip pdo_mysql gd

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . .

RUN composer install

RUN cp .env.example .env

RUN php artisan key:generate

CMD ["php", "artisan", "serve", "--host", "0.0.0.0"]
