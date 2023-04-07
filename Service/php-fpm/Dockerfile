ARG PHP_VERSION
FROM ${PHP_VERSION}

# Extensions Version Define
ARG PHPREDIS_VERSION=4.1.0
ARG PHPSWOOLE_VERSION=4.8.9
ARG PHPPROTOBUF_VERSION=0.12.3

# Work Dir
COPY ./extensions /tmp/extensions
WORKDIR /tmp/extensions

# Other
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

# Init
# sh需要指向Bash以支持更多特性，很多Docker官方镜像使用的sh指向Dash
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add --no-cache autoconf g++ libtool make curl-dev gettext-dev vim strace bash zip \
    && docker-php-ext-install -j$(nproc) mysqli \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) pcntl \
    && pecl install redis-${PHPREDIS_VERSION}.tgz \
    && pecl install swoole-${PHPSWOOLE_VERSION}.tgz \
    && unzip php-protobuf-${PHPPROTOBUF_VERSION}.zip \
    && ( \
        cd php-protobuf-${PHPPROTOBUF_VERSION} \
        && phpize \
        && ./configure \
        && make \
        && make install \
    ) \
    && docker-php-ext-enable redis swoole protobuf \
    && install-php-extensions xhprof \
    && rm -rf /tmp/extensions \
    && rm /bin/sh  \
    && ln -s /bin/bash /bin/sh

# 设置Env PS1
ENV PS1='[\u@\h \W] '

# Work Dir
WORKDIR /www