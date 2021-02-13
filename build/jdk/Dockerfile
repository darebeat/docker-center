FROM darebeat/ssh

MAINTAINER darebeat<darebeat@126.com>

ARG JDK_VERSION=201
# java
RUN wget -q --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/8u${JDK_VERSION}-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u${JDK_VERSION}-linux-x64.tar.gz && \
    tar -xvzf jdk-8u${JDK_VERSION}-linux-x64.tar.gz -C /opt && \
    rm -rf jdk-8u${JDK_VERSION}-linux-x64.tar.gz

# ENV
ENV JAVA_HOME=/opt/jdk1.8.0_${JDK_VERSION} \
    PATH=$JAVA_HOME/bin:$PATH