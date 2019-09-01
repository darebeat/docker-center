#!/bin/bash

: ${HADOOP_PREFIX:=/opt/hadoop}

$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

echo -e "\n"

$HADOOP_PREFIX/sbin/start-dfs.sh

echo -e "\n"

$HADOOP_PREFIX/sbin/start-yarn.sh
# $HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver

# service sshd start
/usr/sbin/sshd -D
