FROM daocloud.io/darebeat/hadoop

MAINTAINER darebeat<darebeat@126.com>

ARG HIVE_VERSION=2.3.4
ENV HIVE_HOME=/opt/hive
ENV PATH=$PATH:$HIVE_HOME/bin:.

# 安装 Hive
RUN wget http://mirrors.hust.edu.cn/apache/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    tar -xzvf apache-hive-${HIVE_VERSION}-bin.tar.gz -C /opt/ && \
    mv /opt/apache-hive-${HIVE_VERSION}-bin $HIVE_HOME && \
    rm -rf apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    rm -rf $HIVE_HOME/examples && \
    wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.tar.gz && \
    tar -xzvf mysql-connector-java-5.1.40.tar.gz -C /opt/ && \
    mv /opt/mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar $HIVE_HOME/lib/ && \
    rm -rf /opt/mysql-connector-java-5.1.40 && \
    rm -rf mysql-connector-java-5.1.40.tar.gz

# 拷贝Hive配置文件
COPY src/config/* $HIVE_HOME/conf/
