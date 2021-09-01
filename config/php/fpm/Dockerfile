FROM php:8.1.0-fpm

ARG PROJECT_NAME

ARG GITHUB_USER
ARG GITHUB_TOKEN
ARG GITHUB_EMAIL
ARG GITHUB_NAME

RUN apt update \
    && apt upgrade -y \
    && apt install -y \
        g++ \
        libbz2-dev \
        libc-client-dev \
        libcurl4-gnutls-dev \
        libedit-dev \
        libfreetype6-dev \
        libicu-dev \
        libjpeg62-turbo-dev \
        libkrb5-dev \
        libldap2-dev \
        libmagickwand-dev \
        libmcrypt-dev \
        libmemcached-dev \
        libpq-dev \
        libsqlite3-dev \
        libssl-dev \
        libreadline-dev \
        libxslt1-dev \
        libzip-dev \
        memcached \
        wget \
        zip \
        unzip \
        zlib1g-dev \
        nano \
        git \
        xfonts-75dpi \
        xfonts-base \
        libnss3-tools

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer config --global github-protocols https \
    && composer config --global process-timeout 0

RUN wget https://get.symfony.com/cli/installer -O - | bash \
    && mv /root/.symfony/bin/symfony /usr/local/bin/symfony

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -yq nodejs build-essential
RUN npm install -g npm

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
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install -j$(nproc) imap \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install ldap \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        bz2 \
        calendar \
        exif \
        gettext \
        mysqli \
        opcache \
        pdo_mysql \
        pdo_pgsql \
        pgsql \
        soap \
        sockets \
        xsl \
        zip \
        pcntl

RUN pecl install xdebug && docker-php-ext-enable xdebug \
    && pecl install memcached && docker-php-ext-enable memcached \
    && pecl install mongodb && docker-php-ext-enable mongodb \
    && pecl install redis && docker-php-ext-enable redis \
    && yes '' | pecl install imagick && docker-php-ext-enable imagick

RUN docker-php-source delete \
    && apt-get remove -y g++ wget \
    && apt-get autoremove --purge -y && apt-get autoclean -y && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*

RUN mkdir /var/www/$PROJECT_NAME
WORKDIR /var/www/$PROJECT_NAME
