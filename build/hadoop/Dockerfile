FROM daocloud.io/darebeat/jdk8

MAINTAINER darebeat<darebeat@126.com>

ARG JDK_VERSION=141
ARG HADOOP_VERSION=2.7.2


WORKDIR /root

# install hadoop
RUN wget https://github.com/kiwenlau/compile-hadoop/releases/download/${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar -xzvf hadoop-${HADOOP_VERSION}.tar.gz && \
    mv hadoop-${HADOOP_VERSION} /opt/hadoop && \
    rm hadoop-${HADOOP_VERSION}.tar.gz

# set environment variable
ENV JAVA_HOME=/opt/jdk1.8.0_${JDK_VERSION}
ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_PREFIX=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_YARN_HOME=$HADOOP_HOME
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

COPY src/config/* /tmp/

RUN mkdir -p $HADOOP_HOME/namenode && \
    mkdir -p $HADOOP_HOME/datanode && \
    mkdir -p $HADOOP_HOME/tmp && \
    mkdir $HADOOP_HOME/logs && \
    mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/bootstrap.sh /bootstrap.sh && \
    mv /tmp/wordcount.sh ~/wordcount.sh && \
    mv /tmp/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    chmod +x /bootstrap.sh && \
    chmod +x ~/wordcount.sh && \
    chmod +x $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh

# format namenode
RUN $HADOOP_HOME/bin/hdfs namenode -format

CMD ["/usr/sbin/sshd", "-D"]
