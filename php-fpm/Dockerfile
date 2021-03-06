FROM hub.c.163.com/library/php:5.6.30-fpm-alpine

MAINTAINER  Frank Wu "gang.wu@istuary.com"

# share log file
RUN mkdir -p /data/php-fpm/log
WORKDIR /data/php-fpm
VOLUME ["/data/php-fpm/log"]

# skip installing gem documentation
RUN echo -e "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main\n\
https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/community\n\
https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/testing" > /etc/apk/repositories && \
    mkdir -p /usr/local/etc \
	&& { \
		echo 'install: --no-document'; \
		echo 'update: --no-document'; \
	} >> /usr/local/etc/gemrc

# Set Timezone Environments
ENV TIMEZONE            Asia/Shanghai
RUN \
	apk add --update tzdata && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone && \
	apk del tzdata

# Install Software
RUN apk add --no-cache --virtual .ext-deps \
        bash \
        curl \
        git \
        nodejs \
        libjpeg-turbo-dev \
        libwebp-dev \
        libpng-dev \
        libxml2-dev \
        freetype-dev \
        libmcrypt \
        autoconf

RUN docker-php-ext-configure pdo
RUN docker-php-ext-configure pdo_mysql
RUN docker-php-ext-configure opcache
RUN docker-php-ext-configure exif
RUN docker-php-ext-configure sockets
RUN docker-php-ext-configure soap
RUN docker-php-ext-configure bcmath
RUN docker-php-ext-configure pcntl
RUN docker-php-ext-configure sysvsem
RUN docker-php-ext-configure tokenizer
RUN docker-php-ext-configure zip
RUN docker-php-ext-configure shmop
RUN docker-php-ext-configure xmlrpc
RUN docker-php-ext-configure mysqli
RUN docker-php-ext-configure mysql
RUN docker-php-ext-configure gd \
    --with-jpeg-dir=/usr/include --with-png-dir=/usr/include --with-webp-dir=/usr/include --with-freetype-dir=/usr/include

# Install and Enable Redis Xdebug Mongodb
RUN \
    apk add --no-cache --virtual .mongodb-ext-build-deps openssl-dev && \
    pecl install mongodb && \
    pecl clear-cache && \
    apk del .mongodb-ext-build-deps && \
	docker-php-ext-enable mongodb.so

# Install PHP extention
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install opcache
RUN docker-php-ext-install exif
RUN docker-php-ext-install sockets
RUN docker-php-ext-install soap
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install sysvsem
RUN docker-php-ext-install tokenizer
RUN docker-php-ext-install zip
RUN docker-php-ext-install shmop
RUN docker-php-ext-install xmlrpc
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install mysql
RUN docker-php-ext-install gd

# Delete PHP Source
RUN docker-php-source delete

# Install Composer
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Install APIDoc
RUN npm install apidoc -g

# Install APIDoc for Grunt
RUN npm install grunt-apidoc --save-dev

# Copy php.ini
COPY ./php.ini /usr/local/etc/php

# Copy php fpm
COPY ./php-fpm.conf  /etc/php5/php-fpm.conf

EXPOSE 9000
CMD ["php-fpm"]