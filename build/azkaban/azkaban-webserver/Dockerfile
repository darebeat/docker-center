# BUILD: docker build --rm -t darebeat/azkaban-webserver .

FROM alpine

MAINTAINER darebeat <darebeat@126.com>

ENV AZK_VERSION 3.57.0
ENV MYSQL_JDBC_VERSION 5.1.35

RUN apk add --update openjdk8-jre curl bash mysql-client && rm -rf /var/cache/apk/*

#install web-server
COPY azkaban-web-server-$AZK_VERSION.tar.gz /azkaban-web-server-$AZK_VERSION.tar.gz
RUN tar xzvf azkaban-web-server-$AZK_VERSION.tar.gz
RUN rm -fr azkaban-web-server-$AZK_VERSION.tar.gz

RUN curl -sLk http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$MYSQL_JDBC_VERSION.tar.gz| tar xz
RUN mv mysql-connector-java-$MYSQL_JDBC_VERSION/mysql-connector-java-$MYSQL_JDBC_VERSION-bin.jar azkaban-web-server-$AZK_VERSION/lib/
RUN rm -rf mysql-connector-java-$MYSQL_JDBC_VERSION
RUN mkdir azkaban-web-server-$AZK_VERSION/logs/
# Work around to run container as a daemon
RUN sed -i "s/&//" /azkaban-web-server-$AZK_VERSION/bin/start-web.sh

ADD keystore /azkaban-web-server-$AZK_VERSION/keystore
ADD conf/azkaban.properties /azkaban-web-server-$AZK_VERSION/conf/azkaban.properties

# Azkaban web server port
EXPOSE 8443

# Define default workdir
WORKDIR /azkaban-web-server-$AZK_VERSION

#CMD ["bin/start-web.sh;/bin/bash"]
CMD bash -C 'bin/start-web.sh';'bash'
