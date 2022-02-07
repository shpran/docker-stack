FROM php:8.1.2-fpm

ENV CFLAGS="$CFLAGS -D_GNU_SOURCE"

ARG PROJECT_NAME

ARG GITHUB_USER
ARG GITHUB_TOKEN
ARG GITHUB_EMAIL
ARG GITHUB_NAME

RUN apt update \
    && apt install -y \
        debian-archive-keyring \
        libonig-dev \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libpq-dev \
        libzip-dev \
        libzstd-dev \
        zip \
        unzip \
        sudo \
        nano \
        git \
        wget \
        curl \
        libcurl4-gnutls-dev \
    && rm -rf /var/lib/apt/lists/*

RUN echo 'deb [trusted=yes] https://repo.symfony.com/apt/ /' | sudo tee /etc/apt/sources.list.d/symfony-cli.list \
    && apt update \
    && apt install symfony-cli

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer config --global github-protocols https \
    && composer config --global process-timeout 0

RUN wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
    && mv git-completion.bash /usr/local/share/.git-completion.bash

RUN git config --global user.email "${GITHUB_EMAIL}" \
    && git config --global user.name "${GITHUB_NAME}" \
    && git config --global credential.helper store
RUN touch ~/.git-credentials \
    && echo https://$GITHUB_USER:$GITHUB_TOKEN@github.com > ~/.git-credentials

ADD ./bashrc_config.txt /usr/local/share/bashrc_config.txt
RUN cat >> ~/.bashrc /usr/local/share/bashrc_config.txt \
    && /bin/bash -c 'source ~/.bashrc'

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd

RUN pecl install \
    igbinary \
    redis \
    xdebug

RUN docker-php-ext-install pdo \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install gd \
    && docker-php-ext-install opcache \
    && docker-php-ext-install zip \
    && docker-php-ext-install curl \
    && docker-php-ext-install calendar \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install sockets \
    && docker-php-ext-enable igbinary \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-enable redis

RUN mkdir /var/www/tools
RUN mkdir /var/www/tools/php-cs-fixer \
    && composer require --working-dir=/var/www/tools/php-cs-fixer friendsofphp/php-cs-fixer

RUN docker-php-source delete \
    && apt remove -y wget \
    && apt autoremove --purge -y \
    && apt autoclean -y \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*

RUN mkdir /var/www/$PROJECT_NAME
WORKDIR /var/www/$PROJECT_NAME
