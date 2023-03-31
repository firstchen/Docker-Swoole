ARG PHP_VERSION
FROM ${PHP_VERSION}

# Init
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add --no-cache autoconf g++ libtool make curl-dev gettext-dev vim strace bash zip \
        && docker-php-ext-install -j$(nproc) mysqli \
            && docker-php-ext-install -j$(nproc) pdo_mysql

# Extensions
ARG PHPPROTOBUF_VERSION=0.12.3
ARG PHPREDIS_VERSION=4.1.0
ARG PHPSWOOLE_VERSION=4.8.9
COPY ./extensions /tmp/extensions
WORKDIR /tmp/extensions
RUN pecl install redis-${PHPREDIS_VERSION}.tgz \
    && pecl install swoole-${PHPSWOOLE_VERSION}.tgz \
    && docker-php-ext-enable redis swoole

# Proto
RUN unzip php-protobuf-${PHPPROTOBUF_VERSION}.zip \
    && ( \
        cd php-protobuf-${PHPPROTOBUF_VERSION} \
        && phpize \
        && ./configure \
        && make \
        && make install \
    ) \
    && docker-php-ext-enable protobuf \
    && rm -rf /tmp/extensions

# Other
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions xhprof

WORKDIR /www