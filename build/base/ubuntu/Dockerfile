FROM ubuntu:16.04
MAINTAINER darebeat<darebeat@126.com>

ARG JDK_VERSION=141
COPY src/config/* /tmp/

# install some common packages.
RUN mv /tmp/sources.list /etc/apt/ \
    && apt-get update \
    && apt-get --no-install-recommends install -y apt-utils git vim wget iputils-ping netcat-traditional openssh-server openssh-client \
    && wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u${JDK_VERSION}-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u${JDK_VERSION}-linux-x64.tar.gz \
    && tar -xvzf jdk-8u${JDK_VERSION}-linux-x64.tar.gz -C /opt \
    && rm -rf jdk-8u${JDK_VERSION}-linux-x64.tar.gz \
    && apt-get --no-install-recommends install -y python3 python3-pip scala \
    && rm -rf /var/lib/apt/lists/* && apt-get clean \
    && ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
    && chmod 700 ~/.ssh \
    && chmod 600 ~/.ssh/id_rsa \
    && chmod 644 ~/.ssh/authorized_keys \
    && mkdir -p /var/run/sshd \
    && mv /tmp/config ~/.ssh \
    && mv /tmp/wait-for /usr/local/bin \
    && chmod +x /usr/local/bin/wait-for

ENV JAVA_HOME /opt/jdk1.8.0_${JDK_VERSION}
ENV PATH $JAVA_HOME/bin:$PATH

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
