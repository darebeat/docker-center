FROM php:alpine3.13
LABEL maintainer=darebeat@126.com
# https://www.cnblogs.com/weblm/p/15003138.html

ENV TZ "Asia/Shanghai"
ENV TERM xterm
# 默认关闭opcode
ENV OPCODE 0

ARG KODEXPLORER_VERSION=4.47
ARG KODEXPLORER_URL="https://github.com/kalcaddle/KodExplorer/archive/refs/tags/$KODEXPLORER_VERSION.tar.gz"

RUN set -x \
  && mkdir -p /usr/src/kodexplorer \
  && sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
  && echo -e nameserver 114.114.114.114 > /etc/resolv.conf \
  && apk --update --no-cache add wget bash \
  && wget -q -O /tmp/kodexplorer.tar.gz "$KODEXPLORER_URL" \
  && tar -xzf /tmp/kodexplorer.tar.gz -C /usr/src/kodexplorer/ --strip-components=1 \
  && rm -rf /tmp/*

RUN set -x \
  && apk add --no-cache \
       freetype \
       freetype-dev \
       libpng \
       libjpeg-turbo \
       libpng-dev \
       jpeg-dev \
       libjpeg \
       libjpeg-turbo-dev \
       libwebp \
       libwebp-dev \
  && docker-php-ext-configure gd --with-webp=/usr/include/webp --with-jpeg=/usr/include --with-freetype=/usr/include/freetype2/ \
  && docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" gd 

WORKDIR /var/www/html

COPY entrypoint.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/entrypoint.sh

EXPOSE 80

ENTRYPOINT ["entrypoint.sh"]
CMD [ "php", "-S", "0000:80", "-t", "/var/www/html" ]