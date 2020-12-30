#!/bin/sh

declare -r CURR_DIR=$(cd `dirname $0`;pwd)

REPLICA=ch1 SHARD=01 envsubst < ${CURR_DIR}/config_tmpl.xml > ${CURR_DIR}/conf/config_01.xml
REPLICA=ch2 SHARD=01 envsubst < ${CURR_DIR}/config_tmpl.xml > ${CURR_DIR}/conf/config_02.xml
REPLICA=ch3 SHARD=02 envsubst < ${CURR_DIR}/config_tmpl.xml > ${CURR_DIR}/conf/config_03.xml
REPLICA=ch4 SHARD=02 envsubst < ${CURR_DIR}/config_tmpl.xml > ${CURR_DIR}/conf/config_04.xml