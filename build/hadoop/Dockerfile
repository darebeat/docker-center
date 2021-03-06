FROM daocloud.io/darebeat/base

MAINTAINER darebeat<darebeat@126.com>

ARG JDK_VERSION=141
ARG HADOOP_VERSION=2.6.0
ARG HADOOP_HOME=/opt/hadoop

WORKDIR /root

# set environment variable
ENV JAVA_HOME=/opt/jdk1.8.0_${JDK_VERSION} \
    HADOOP_VERSION=$HADOOP_VERSION \
    HADOOP_HOME=$HADOOP_HOME \
    HADOOP_PREFIX=$HADOOP_HOME \
    HADOOP_COMMON_HOME=$HADOOP_HOME \
    HADOOP_HDFS_HOME=$HADOOP_HOME \
    HADOOP_MAPRED_HOME=$HADOOP_HOME \
    HADOOP_YARN_HOME=$HADOOP_HOME \
    HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop \
    YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop \
    PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

COPY src/config/* /tmp/

# install hadoop
RUN wget http://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar -xzf hadoop-${HADOOP_VERSION}.tar.gz && \
    mv hadoop-${HADOOP_VERSION} $HADOOP_HOME && \
    rm hadoop-${HADOOP_VERSION}.tar.gz && \
    mkdir -p $HADOOP_HOME/namenode && \
    mkdir -p $HADOOP_HOME/namesecondary && \
    mkdir -p $HADOOP_HOME/datanode && \
    mkdir -p $HADOOP_HOME/tmp && \
    mkdir $HADOOP_HOME/logs && \
    mv /tmp/bootstrap.sh /bootstrap.sh && \
    mv /tmp/wordcount.sh /root/wordcount.sh && \
    mv /tmp/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/masters $HADOOP_HOME/etc/hadoop/masters && \
    mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    chmod +x /bootstrap.sh && \
    chmod +x /root/wordcount.sh && \
    chmod +x $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh

# format namenode
RUN $HADOOP_HOME/bin/hdfs namenode -format

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
