FROM darebeat/jdk8:ssh

MAINTAINER darebeat<darebeat@126.com>

ARG ZK_VERSION=3.4.13
ENV	ZK_HOME=/opt/zookeeper-${ZK_VERSION} \
	ZK_CONF_DIR=/opt/zookeeper-${ZK_VERSION}/conf \
    ZK_DATA_DIR=/opt/zookeeper-${ZK_VERSION}/data \
    ZK_DATA_LOG_DIR=/opt/zookeeper-${ZK_VERSION}/logs \
    ZK_PORT=2181 \
    ZK_TICK_TIME=2000 \
    ZK_INIT_LIMIT=5 \
    ZK_SYNC_LIMIT=2 \
    ZK_MAX_CLIENT_CNXNS=60

# Download Zookeeper
RUN wget -q http://mirror.vorboss.net/apache/zookeeper/zookeeper-${ZK_VERSION}/zookeeper-${ZK_VERSION}.tar.gz \
&& tar -xzf zookeeper-${ZK_VERSION}.tar.gz -C /opt \
&& rm -rf zookeeper-${ZK_VERSION}.tar.gz

EXPOSE ${ZK_PORT} 2888 3888

WORKDIR ${ZK_HOME}
VOLUME ["${ZK_CONF_DIR}", "${ZK_DATA_DIR}"]

ENV PATH=$PATH:/opt/zookeeper-${ZK_VERSION}/bin \
    ZOOCFGDIR=/opt/zookeeper-${ZK_VERSION}/conf

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["zkServer.sh", "start-foreground"]