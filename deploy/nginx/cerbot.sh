#!/usr/bin/env bash

declare -r CURR_DIR=$(cd `dirname $0`; pwd)

ARG=${1:-renew}

if [ "${ARG}" == 'certonly' ]; then

echo """docker run -it --rm -v ${CURR_DIR}/conf/certs:/etc/letsencrypt certbot/certbot \\
  certonly --verbose \\
    --noninteractive \\
    --standalone \\
    --agree-tos \\
    -m darebeat@126.com \\
    -d darebeat.cn"""

docker run -it --rm -v ${CURR_DIR}/conf/certs:/etc/letsencrypt certbot/certbot \
  certonly --verbose \
    --noninteractive \
    --standalone \
    --agree-tos \
    -m darebeat@126.com \
    -d darebeat.cn
elif [ "${ARG}" == 'renew' ]; then

echo """docker run -it --rm -v ${CURR_DIR}/conf/certs:/etc/letsencrypt certbot/certbot \\
  renew --verbose \\
    --noninteractive \\
    --standalone \\
    --agree-tos \\
    -m darebeat@126.com \\
    -d darebeat.cn"""

docker run -it --rm -v ${CURR_DIR}/conf/certs:/etc/letsencrypt certbot/certbot \
  renew --verbose \
    --noninteractive \
    --standalone \
    --agree-tos \
    -m darebeat@126.com \
    -d darebeat.cn
else
  echo "$@"
fi


