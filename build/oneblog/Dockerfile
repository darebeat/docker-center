FROM maven:3.6.3-jdk-8 AS build
WORKDIR /build
RUN git clone https://github.com/zhangyd-c/OneBlog.git /build
RUN mvn clean package -Dmaven.test.skip=true -Pdev


FROM openjdk:8-jdk-alpine
MAINTAINER darebeat<darebeat@126.com>
ARG ONEBLOG_VERSION=2.2.2

WORKDIR /app/oneblog
COPY docker-entrypoint.sh /
COPY --from=build /build/target/blog-*.jar /app/oneblog
ENV TZ=Asia/Shanghai
# EXPOSE 8085 8443

ENTRYPOINT ["/docker-entrypoint.sh"]