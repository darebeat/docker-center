FROM alpine:3.10

MAINTAINER darebeat<darebeat@126.com>

ARG JDK_VERSION=1.8.0_252
ARG JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk

# sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && apk update
RUN apk add --no-cache openjdk8 tzdata curl \
  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && apk del tzdata

ENV JAVA_HOME=$JAVA_HOME \
    JAVA_VERSION=$JDK_VERSION \
    PATH=$PATH:$JAVA_HOME/jre/bin:$JAVA_HOME/bin