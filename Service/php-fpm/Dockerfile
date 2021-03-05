ARG PHP_VERSION
FROM ${PHP_VERSION}

# Init
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add --no-cache autoconf g++ libtool make curl-dev gettext-dev vim \
        && docker-php-ext-install -j$(nproc) mysqli \
            && docker-php-ext-install -j$(nproc) pdo_mysql

# Extensions
ARG PHPREDIS_VERSION=4.1.0
ARG PHPSWOOLE_VERSION=4.4.2
COPY ./extensions /tmp/extensions
WORKDIR /tmp/extensions
RUN pecl install redis-${PHPREDIS_VERSION}.tgz \
    && pecl install swoole-${PHPSWOOLE_VERSION}.tgz \
    && docker-php-ext-enable redis swoole \
    && rm -rf /tmp/extensions

WORKDIR /www