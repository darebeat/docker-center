FROM daocloud.io/darebeat/ssh

MAINTAINER darebeat<darebeat@126.com>

# java
RUN wget -q --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" \
	https://download.oracle.com/otn/java/jdk/8u221-b11/230deb18db3e4014bb8e3e8324f81b43/jdk-8u221-linux-x64.tar.gz && \
    tar -xvzf jdk-8u${JDK_VERSION}-linux-x64.tar.gz -C /opt && \
    rm -rf jdk-8u${JDK_VERSION}-linux-x64.tar.gz

# ENV
ENV JAVA_HOME /opt/jdk1.8.0_${JDK_VERSION}
ENV PATH $JAVA_HOME/bin:$PATH