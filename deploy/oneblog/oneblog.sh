#! /bin/bash

BASE_PATH=$(cd `dirname $0`; pwd)

usage() {
  echo "Please select running type: "
  echo "start        start oneblog server"
  echo "stop         stop oneblog server"
  echo "restart      restart oneblog server"
  echo "> sh oneblog.sh [ start/stop/restart/down ]"
  exit 1
}

test(){
  # the base env for oneblog to test.
  rm -rf ${BASE_PATH}/db
  docker-compose -f ${BASE_PATH}/docker-compose-mysql.yaml up -d
  docker-compose -f ${BASE_PATH}/docker-compose-redis.yaml up -d
  docker-compose -f ${BASE_PATH}/docker-compose-nginx.yaml up -d
}

start(){
  docker-compose -f ${BASE_PATH}/docker-compose-mysql.yaml up -d
  docker-compose -f ${BASE_PATH}/docker-compose-redis.yaml up -d
  docker-compose -f ${BASE_PATH}/docker-compose-nginx.yaml up -d
  sleep 1m
  docker-compose -f ${BASE_PATH}/docker-compose-oneblog.yaml up -d
}

stop(){
  docker-compose -f ${BASE_PATH}/docker-compose-mysql.yaml stop
  docker-compose -f ${BASE_PATH}/docker-compose-redis.yaml stop
  docker-compose -f ${BASE_PATH}/docker-compose-oneblog.yaml stop
  docker-compose -f ${BASE_PATH}/docker-compose-nginx.yaml stop
}

restart(){
  docker-compose -f ${BASE_PATH}/docker-compose-mysql.yaml start
  docker-compose -f ${BASE_PATH}/docker-compose-redis.yaml start
  docker-compose -f ${BASE_PATH}/docker-compose-oneblog.yaml start
  docker-compose -f ${BASE_PATH}/docker-compose-nginx.yaml start
}

down(){
  docker-compose -f ${BASE_PATH}/docker-compose-mysql.yaml down -v
  docker-compose -f ${BASE_PATH}/docker-compose-redis.yaml down -v
  docker-compose -f ${BASE_PATH}/docker-compose-oneblog.yaml down -v
  docker-compose -f ${BASE_PATH}/docker-compose-nginx.yaml down -v
}

case "$1" in
  "start")
    start
    ;;
  "stop")
    stop
    ;;
  "restart")
    restart
    ;;
  "down")
    down
    ;;
  "test")
    test
    ;;
  *)
    usage
    ;;
esac