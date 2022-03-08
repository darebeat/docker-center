# BUILD: docker build --rm -t darebeat/azkaban-executor .

FROM alpine

MAINTAINER darebeat <darebeat@126.com>

USER root

ENV AZK_VERSION 3.57.0
ENV MYSQL_JDBC_VERSION 5.1.35

RUN apk add --update openjdk8-jre curl bash && rm -rf /var/cache/apk/*

COPY azkaban-exec-server-$AZK_VERSION.tar.gz /azkaban-exec-server-$AZK_VERSION.tar.gz
RUN tar xzvf azkaban-exec-server-$AZK_VERSION.tar.gz && \
rm azkaban-exec-server-$AZK_VERSION.tar.gz
RUN curl -sLk http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$MYSQL_JDBC_VERSION.tar.gz| tar xz
RUN mv mysql-connector-java-$MYSQL_JDBC_VERSION/mysql-connector-java-$MYSQL_JDBC_VERSION-bin.jar azkaban-exec-server-$AZK_VERSION/lib/
RUN rm -rf mysql-connector-java-$MYSQL_JDBC_VERSION
# Work around to run container as a daemon
RUN sed -i "s/&//" /azkaban-exec-server-$AZK_VERSION/bin/start-exec.sh

ADD conf/azkaban.properties /azkaban-exec-server-$AZK_VERSION/conf/azkaban.properties

# Azkaban executor port
EXPOSE 12321

# Define default workdir
WORKDIR /azkaban-exec-server-$AZK_VERSION

#CMD ["bin/start-exec.sh;/bin/bash"]
CMD bash -C 'bin/start-exec.sh';'bash'
