FROM alpine:3.7

MAINTAINER darebeat<darebeat@126.com>

ENV SYS_ARCH=amd64 \
    FRP_VER=0.34.1 \
    FRP_HOME=/opt/frp \
    PATH=$PATH:$FRP_HOME/bin

COPY docker-entrypoint.sh /

RUN apk --no-cache add wget tar tzdata \
  && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v${FRP_VER}/frp_${FRP_VER}_linux_${SYS_ARCH}.tar.gz && tar zxvf frp_${FRP_VER}_linux_${SYS_ARCH}.tar.gz \
  && rm -rf frp_${FRP_VER}_linux_${SYS_ARCH}.tar.gz \
  && mkdir -p /opt/frp/conf \
  && mkdir -p /opt/frp/bin \ 
  && cp frp_${FRP_VER}_linux_${SYS_ARCH}/frps /opt/frp/bin \
  && cp frp_${FRP_VER}_linux_${SYS_ARCH}/frpc /opt/frp/bin \
  && cp frp_${FRP_VER}_linux_${SYS_ARCH}/frps.ini /opt/frp/conf \
  && cp frp_${FRP_VER}_linux_${SYS_ARCH}/frpc.ini /opt/frp/conf \
  && rm -rf frp_${FRP_VER}_linux_${SYS_ARCH} \
  && chmod +x /opt/frp/bin/frps \
  && chmod +x /opt/frp/bin/frpc \
  && apk del --purge wget tar

WORKDIR /opt/frp

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh", "-c"]