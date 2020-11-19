#!/bin/bash

declare -r CURR_DIR=$(cd `dirname $0`;pwd)

echo "-----START " `date +"%Y-%m-%d %H:%M:%S"` "-----"  >> ${CURR_DIR}/renew.log

# # dnspod
# docker run --rm -it \
# -v ${CURR_DIR}/dnspod.conf:/opt/certbot/dnspod.conf \  # dnspod配置文件
# -v ${CURR_DIR}/etc:/etc/letsencrypt \
# -v ${CURR_DIR}/lib:/var/lib/letsencrypt \
# -v ${CURR_DIR}/log:/var/log/letsencrypt \
# darebeat/certbot renew  >> ${CURR_DIR}/renew.log 2>&1

# hwy/aly/txy/godaddy
docker run --rm -it \
-v ${CURR_DIR}/etc:/etc/letsencrypt \
-v ${CURR_DIR}/lib:/var/lib/letsencrypt \
-v ${CURR_DIR}/log:/var/log/letsencrypt \
-v ${CURR_DIR}/domains:/opt/certbot/certbot-dns-cnyun/domains \  # 根据需要进行扩展
--env-file ${CURR_DIR}/.env \  # api key/token config
darebeat/certbot renew
  --manual --preferred-challenges dns \
  --manual-auth-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh hwy add" \
  --manual-cleanup-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh hwy clean" >> ${CURR_DIR}/renew.log 2>&1

scp -r ${CURR_DIR}/etc/darebeat.cn txy:/root/projects/docker-center/deploy/nginx/conf/certs >> ${CURR_DIR}/renew.log

echo "-----END" `date +"%Y-%m-%d %H:%M:%S"`"-----"  >> ${CURR_DIR}/renew.log