FROM daocloud.io/darebeat/ssh

MAINTAINER darebeat<darebeat@126.com>

ARG JDK_VERSION=141

# java
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u${JDK_VERSION}-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u${JDK_VERSION}-linux-x64.tar.gz && \
    tar -xvzf jdk-8u${JDK_VERSION}-linux-x64.tar.gz -C /opt && \
    rm -rf jdk-8u${JDK_VERSION}-linux-x64.tar.gz

# ENV
ENV JAVA_HOME /opt/jdk1.8.0_${JDK_VERSION}
ENV PATH $JAVA_HOME/bin:$PATH
