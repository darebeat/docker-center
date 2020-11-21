FROM certbot/certbot:v1.7.0

MAINTAINER darebeat<darebeat@126.com>
WORKDIR /opt/certbot
COPY certbot-dns-cnyun /opt/certbot/certbot-dns-cnyun
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN pip install certbot-dns-dnspod
ENV TZ=Asia/Shanghai \
    PATH=$PATH:/opt/certbot/certbot-dns-cnyun

ENTRYPOINT ["/docker-entrypoint.sh"]