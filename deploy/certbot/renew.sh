#!/bin/sh

# USAGE:
# $1: ssh 连接; 如root@darebeat.cn
## sh +x renew.sh txy /etc/nginx/ssl

declare -r CURR_DIR=$(cd `dirname $0`;pwd)

COPY_PATH=${CURR_DIR}/etc
TARG_PATH=${2:-${CURR_DIR}/../nginx/conf/certs}
LOG_PATH=${CURR_DIR}/log

echo "--- START: `date +"%Y-%m-%d %H:%M:%S"` ---
COPY_PATH: ${COPY_PATH}
TARG_PATH: ${TARG_PATH}
LOG_PATH : ${LOG_PATH} " >> ${LOG_PATH}/renew.log

scp -r ${COPY_PATH} ${1:-txy}:${TARG_PATH} >> ${LOG_PATH}/renew.log

echo "---   END: `date +"%Y-%m-%d %H:%M:%S"` ---
" >> ${LOG_PATH}/renew.log