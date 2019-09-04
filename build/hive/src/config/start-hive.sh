#!/usr/bin/env bash

set -x

if [ "${1:-start}" = "init" ]; then
	hdfs dfs -mkdir /tmp
	hdfs dfs -mkdir /user
	hdfs dfs -mkdir /user/hive
	hdfs dfs -mkdir /user/hive/warehouse
	hdfs dfs -chmod g+w /tmp
	hdfs dfs -chmod g+w /user/hive/warehouse

	rm -rf $HIVE_HOME/metastore

	$HIVE_HOME/bin/schematool -dbType derby -initSchema
else
	$HIVE_HOME/bin/hiveserver2 --hiveconf hive.root.logger=DEBUG,console
fi
