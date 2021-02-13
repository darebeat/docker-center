#! /bin/bash

BASE_PATH=$(cd `dirname $0`; pwd)

usage() {
  echo "Please select database type: "
  echo "start        start oneblog server"
  echo "stop         stop oneblog server"
  echo "restart      restart oneblog server"
  echo "> sh oneblog.sh [ start/stop/restart/down ]"
  exit 1
}

start(){
  docker-compose -f ${BASE_PATH}/docker-compose-mysql.yaml up -d
  docker-compose -f ${BASE_PATH}/docker-compose-redis.yaml up -d
  sleep 1m
  docker-compose -f ${BASE_PATH}/docker-compose-oneblog.yaml up -d
}

stop(){
  docker-compose -f ${BASE_PATH}/docker-compose-mysql.yaml stop
  docker-compose -f ${BASE_PATH}/docker-compose-redis.yaml stop
  docker-compose -f ${BASE_PATH}/docker-compose-oneblog.yaml stop
}

restart(){
  docker-compose -f ${BASE_PATH}/docker-compose-mysql.yaml start
  docker-compose -f ${BASE_PATH}/docker-compose-redis.yaml start
  docker-compose -f ${BASE_PATH}/docker-compose-oneblog.yaml start
}

down(){
  docker-compose -f ${BASE_PATH}/docker-compose-mysql.yaml down -v
  docker-compose -f ${BASE_PATH}/docker-compose-redis.yaml down -v
  docker-compose -f ${BASE_PATH}/docker-compose-oneblog.yaml down -v
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
  *)
    usage
    ;;
esac