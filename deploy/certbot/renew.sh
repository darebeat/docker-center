#!/bin/bash

declare -r CURR_DIR=$(cd `dirname $0`;pwd)

echo "-----START " `date +"%Y-%m-%d %H:%M:%S"` "-----"  >> renew.log

# # dnspod
# docker run --rm -it \
# -v `pwd`/dnspod.conf:/opt/certbot/dnspod.conf \  # dnspod配置文件
# -v `pwd`/etc:/etc/letsencrypt \
# -v `pwd`/lib:/var/lib/letsencrypt \
# -v `pwd`/log:/var/log/letsencrypt \
# darebeat/certbot renew  >> renew.log 2>&1

# hwy/aly/txy/godaddy
docker run --rm -it \
-v `pwd`/etc:/etc/letsencrypt \
-v `pwd`/lib:/var/lib/letsencrypt \
-v `pwd`/log:/var/log/letsencrypt \
-v `pwd`/domains:/opt/certbot/certbot-dns-cnyun/domains \  # 根据需要进行扩展
--env-file `pwd`/.env \  # api key/token config
darebeat/certbot renew
  --manual --preferred-challenges dns \
  --manual-auth-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh hwy add" \
  --manual-cleanup-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh hwy clean" >> renew.log 2>&1

echo "-----END" `date +"%Y-%m-%d %H:%M:%S"`"-----"  >> renew.log