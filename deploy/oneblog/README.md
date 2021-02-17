# README

## 搭建测试环境

```sh
./oneblog.sh test

# redis操作
docker exec -it o_redis redis-cli -h 127.0.0.1 -p 6379 -a qwe\!\@#123 --raw
select 5 # 选择数据库
keys * # 列出所有key
FLUSHALL # 清空所有数据库,用于刷新缓存

# 此时,oneblog运行所需的环境已经准备完毕.

# 运行和调试代码
git clone https://github.com/darebeat/OneBlog.git
cd OneBlog

# 代码运行
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


# -Xms256m -Xmx512m
java -server \
  -jar blog-admin/target/blog-admin-${OB_VERSION}.jar \
  --spring.datasource.url=${spring_datasource_url} \
  --spring.datasource.username=${spring_datasource_username} \
  --spring.datasource.password=${spring_datasource_password} \
  --spring.redis.database=${spring_redis_database} \
  --spring.redis.host=${spring_redis_host} \
  --spring.redis.port=${spring_redis_port} \
  --spring.redis.password=${spring_redis_password}
  

java -server \
  -jar blog-web/target/blog-web-${OB_VERSION}.jar \
  --spring.datasource.url=${spring_datasource_url} \
  --spring.datasource.username=${spring_datasource_username} \
  --spring.datasource.password=${spring_datasource_password} \
  --spring.redis.database=${spring_redis_database} \
  --spring.redis.host=${spring_redis_host} \
  --spring.redis.port=${spring_redis_port} \
  --spring.redis.password=${spring_redis_password}

# 代码调试,建议用idea进行
# 修改对应的配置,引入并进行对应调试
grep -r -l 'jdbc:mysql' *
```

## docker部署

```sh
git clone https://github.com/darebeat/docker-center.git
cd docker-center/deploy/oneblog

# 部署运行
sh oneblog.sh start

# 注意,mysql数据库初始化没有进行强制依赖,可以按下面步骤启动
sh oneblog.sh
docker-compose -f ${BASE_PATH:-.}/docker-compose-oneblog.yaml up -d
```
