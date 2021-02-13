#!/bin/sh

BASE_PATH=$(cd `dirname $0`; pwd)
APP_PATH=/app/oneblog
APP_NAME=blog-${1:-web}

echo 'cd $BASE_PATH'

# mysql config
spring_datasource_druid_init="set names utf8mb4"
spring_datasource_druid_driver="com.mysql.jdbc.Driver"
spring_datasource_type="com.alibaba.druid.pool.DruidDataSource"
spring_datasource_url=${spring_datasource_url:-"jdbc:mysql://${MYSQL_HOST}:${MYSQL_PORT}/${MYSQL_DATABASE}"}?useUnicode=true&characterEncoding=utf-8&autoReconnect=true&zeroDateTimeBehavior=convertToNull&allowMultiQueries=true&useSSL=false&allowPublicKeyRetrieval=true
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
  java -server -Xms256m -Xmx512m \
    -jar ${APP_PATH}/${APP_NAME}*.jar \
    -Dspring.profiles.active: prod \
    -Dspring.profiles.include: [center] \
    -Dspring.datasource.druid.connection-init-sqls: ${spring_datasource_druid_init} \
    -Dspring.datasource.druid.driver-class-name: ${spring_datasource_druid_driver} \
    -Dspring.datasource.type: ${spring_datasource_type} \
    -Dspring.datasource.url=${spring_datasource_url} \
    -Dspring.datasource.username=${spring_datasource_username} \
    -Dspring.datasource.password=${spring_datasource_password} \
    -Dspring.redis.database: ${spring_redis_database} \
    -Dspring.redis.host: ${spring_redis_host} \
    -Dspring.redis.port: ${spring_redis_port} \
    -Dspring.redis.password: ${spring_redis_password} \
    -Dspring.session.store-type: redis
  > ${APP_PATH}/${APP_NAME}.out 2>&1
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