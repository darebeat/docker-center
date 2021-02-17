#!/bin/sh

BASE_PATH=$(cd `dirname $0`; pwd)
APP_PATH=/app/oneblog
APP_NAME=blog-${1:-web}

echo 'cd $BASE_PATH'

# mysql config
FIX_URL='useUnicode=true&characterEncoding=utf-8&autoReconnect=true&zeroDateTimeBehavior=convertToNull&allowMultiQueries=true&useSSL=false&allowPublicKeyRetrieval=true'
spring_datasource_url=${spring_datasource_url:-jdbc:mysql://${MYSQL_HOST}:${MYSQL_PORT}/${MYSQL_DATABASE}?${FIX_URL}}
spring_datasource_username=${spring_datasource_username:-"${MYSQL_USERNAME}"}
spring_datasource_password=${spring_datasource_password:-"${MYSQL_PASSWORD}"}
# redis config 
spring_redis_database=${spring_redis_database:-5}
spring_redis_host=${spring_redis_host:-127.0.0.1}
spring_redis_port=${spring_redis_port:-6379}
spring_redis_password=${spring_redis_password:-qwe!@#123}

usage() {
  echo "Please select database type: "
  echo "web        start web server"
  echo "admin      start admin server"
  echo "> sh docker-entrypoint.sh [ web or admin ]"
  exit 1
}

start(){
  mkdir -p ${APP_PATH}/logs
  java -server ${JAVA_ARG_OPT:-"-Xms256m -Xmx512m"} \
    -jar ${APP_PATH}/${APP_NAME}*.jar \
    --spring.datasource.url=${spring_datasource_url} \
    --spring.datasource.username=${spring_datasource_username} \
    --spring.datasource.password=${spring_datasource_password} \
    --spring.redis.database=${spring_redis_database} \
    --spring.redis.host=${spring_redis_host} \
    --spring.redis.port=${spring_redis_port} \
    --spring.redis.password=${spring_redis_password}
  > ${APP_PATH}/logs/${APP_NAME}.out 2>&1
}

case "$1" in
  "web")
    start
    ;;
  "admin")
    start
    ;;
  *)
    usage
    ;;
esac