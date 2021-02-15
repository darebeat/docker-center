# README

```sh
grep -r -l 'jdbc:mysql' *

mvn -X clean package -Dmaven.test.skip=true

OB_VERSION=2.2.2
FIX_URL='useUnicode=true&characterEncoding=utf-8&autoReconnect=true&zeroDateTimeBehavior=convertToNull&allowMultiQueries=true&useSSL=false&allowPublicKeyRetrieval=true'
spring_datasource_url=jdbc:mysql://127.0.0.1:3309/oneblog?${FIX_URL}
spring_datasource_username=oneblog
spring_datasource_password=oneblog...

spring_redis_database=${spring_redis_database:-5}
spring_redis_host=${spring_redis_host:-127.0.0.1}
spring_redis_port=${spring_redis_port:-6379}
spring_redis_password=${spring_redis_password:-'qwe!@#123'}

java -server -Xms256m -Xmx512m \
  -jar blog-admin/target/blog-admin-${OB_VERSION}.jar \
  --spring.datasource.url=${spring_datasource_url} \
  --spring.datasource.username=${spring_datasource_username} \
  --spring.datasource.password=${spring_datasource_password} \
  --spring.redis.database=${spring_redis_database} \
  --spring.redis.host=${spring_redis_host} \
  --spring.redis.port=${spring_redis_port} \
  --spring.redis.password=${spring_redis_password}
  

java -server -Xms256m -Xmx512m \
  -jar blog-web/target/blog-web-${OB_VERSION}.jar \
  --spring.datasource.url=${spring_datasource_url} \
  --spring.datasource.username=${spring_datasource_username} \
  --spring.datasource.password=${spring_datasource_password} \
  --spring.redis.database=${spring_redis_database} \
  --spring.redis.host=${spring_redis_host} \
  --spring.redis.port=${spring_redis_port} \
  --spring.redis.password=${spring_redis_password}
```