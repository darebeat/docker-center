# README

zookeeper


## 1.ENV config args

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

## 2.start with docker-compose

+ docker-compose.yml

```yaml
version: '3'
services:
  zoo1:
    image: darebeat/zookeeper
    restart: always
    container_name: zoo1
    networks:
      deploy:
        ipv4_address: 172.10.0.201
        aliases:
          - zoo1
    ports:
      - 2181:2181
    environment:
      ZK_MY_ID: 1
      ZK_SERVERS: server.1=0.0.0.0:2888:3888 server.2=zoo2:2888:3888 server.3=zoo3:2888:3888

  zoo2:
    image: darebeat/zookeeper
    restart: always
    container_name: zoo2
    networks:
      deploy:
        ipv4_address: 172.10.0.202
        aliases:
          - zoo2
    ports:
      - 2182:2181
    environment:
      ZK_MY_ID: 2
      ZK_SERVERS: server.1=zoo1:2888:3888 server.2=0.0.0.0:2888:3888 server.3=zoo3:2888:3888

  zoo3:
    image: darebeat/zookeeper
    restart: always
    container_name: zoo3
    networks:
      deploy:
        ipv4_address: 172.10.0.203
        aliases:
          - zoo3
    ports:
      - 2183:2181
    environment:
      ZK_MY_ID: 3
      ZK_SERVERS: server.1=zoo1:2888:3888 server.2=zoo2:2888:3888 server.3=0.0.0.0:2888:3888

networks:
  deploy:
    external: true
```

+ start

```sh
docker-compose up -d
docker-compose down -v
```