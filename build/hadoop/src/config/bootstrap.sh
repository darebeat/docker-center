#!/bin/bash

: ${HADOOP_PREFIX:=/usr/local/hadoop}

$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

# service sshd start
/usr/sbin/sshd -D &

echo -e "\n"

$HADOOP_PREFIX/sbin/start-dfs.sh

echo -e "\n"

$HADOOP_PREFIX/sbin/start-yarn.sh
# $HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
