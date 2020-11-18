#!/bin/bash

declare -r CURR_DIR=$(cd `dirname $0`;pwd)

echo "-----START " `date +"%Y-%m-%d %H:%M:%S"` "-----"  >> renew.log

docker run --rm -it \
-v ${CURR_DIR}/dnspod.conf:/opt/certbot/dnspod.conf \
-v ${CURR_DIR}/etc:/etc/letsencrypt \
-v ${CURR_DIR}/lib:/var/lib/letsencrypt \
-v ${CURR_DIR}/log:/var/log/letsencrypt \
darebeat/certbot renew >> renew.log 2>&1

echo "-----END" `date +"%Y-%m-%d %H:%M:%S"`"-----"  >> renew.log