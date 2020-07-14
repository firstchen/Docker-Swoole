ARG PHP_VERSION
FROM ${PHP_VERSION}

# Init
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add --no-cache autoconf g++ libtool make curl-dev gettext-dev \
        && docker-php-ext-install -j$(nproc) mysqli

# Redis Extension
ARG PHPREDIS_VERSION=4.1.0
RUN wget http://pecl.php.net/get/redis-${PHPREDIS_VERSION}.tgz -O /tmp/redis.tar.tgz \
    && pecl install /tmp/redis.tar.tgz \
    && rm -rf /tmp/redis.tar.tgz \
    && docker-php-ext-enable redis

# Swoole Extension
ARG PHPSWOOLE_VERSION=4.4.2
RUN wget http://pecl.php.net/get/swoole-${PHPSWOOLE_VERSION}.tgz -O /tmp/swoole.tar.tgz \
    && pecl install /tmp/swoole.tar.tgz \
    && rm -rf /tmp/swoole.tar.tgz \
    && docker-php-ext-enable swoole