## README

zookeeper


1. ENV config args

```
ZK_CONF_DIR=/opt/zookeeper-${ZK_VERSION}/conf \
ZK_DATA_DIR=/opt/zookeeper-${ZK_VERSION}/data \
ZK_DATA_LOG_DIR=/opt/zookeeper-${ZK_VERSION}/logs \
ZK_PORT=2181
ZK_TICK_TIME=2000
ZK_INIT_LIMIT=5
ZK_SYNC_LIMIT=2
ZK_MAX_CLIENT_CNXNS=60
ZK_MY_ID=1
ZK_SERVERS=server.1=zoo1:2888:3888 server.2=0.0.0.0:2888:3888 server.3=zoo3:2888:3888
```

2. start with docker-compose

+ docker-compose.yml

```yml
version: '3.1'

services:
  zoo1:
    image: darebeat/docker-zookeeper
    restart: always
    container_name: zoo1
    hostname: zoo1
    ports:
      - 2181:2181
    environment:
      ZK_MY_ID: 1
      ZK_SERVERS: server.1=0.0.0.0:2888:3888 server.2=zoo2:2888:3888 server.3=zoo3:2888:3888

  zoo2:
    image: darebeat/docker-zookeeper
    restart: always
    container_name: zoo2
    hostname: zoo2
    ports:
      - 2182:2181
    environment:
      ZK_MY_ID: 2
      ZK_SERVERS: server.1=zoo1:2888:3888 server.2=0.0.0.0:2888:3888 server.3=zoo3:2888:3888

  zoo3:
    image: darebeat/docker-zookeeper
    restart: always
    container_name: zoo3
    hostname: zoo3
    ports:
      - 2183:2181
    environment:
      ZK_MY_ID: 3
      ZK_SERVERS: server.1=zoo1:2888:3888 server.2=zoo2:2888:3888 server.3=0.0.0.0:2888:3888

networks:
  default:
    external:
      name: local
```

+ start

```sh
docker-compose up -d
docker-compose stop
docker-compose rm
```