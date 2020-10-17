FROM alpine:3.7

MAINTAINER darebeat<darebeat@126.com>

ARG SYS_ARCH=amd64

ENV FRP_VER=0.34.1
ENV FRP_HOME /opt/frp
ENV PATH $PATH:$FRP_HOME/bin

RUN apk --no-cache add wget tar tzdata \
  && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && mkdir -p /opt/frp/{conf,bin} \ 
  && wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v${FRP_VER}/frp_${FRP_VER}_linux_${SYS_ARCH}.tar.gz \
  && tar xf frp_${FRP_VER}_linux_${SYS_ARCH}.tar.gz \
  && mv frp_${FRP_VER}_linux_${SYS_ARCH}/{frps,frpc} /opt/frp/bin \
  && mv frp_${FRP_VER}_linux_${SYS_ARCH}/{frps.ini,frpc.ini} /opt/frp/conf \
  && rm -rf frp_${FRP_VER}_linux_${SYS_ARCH}* \
  && chmod +x /opt/frp/bin/* \
  && apk del --purge wget tar

WORKDIR /opt/frp

ADD docker-entrypoint.sh ${FRP_HOME}/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh", "-c"]
