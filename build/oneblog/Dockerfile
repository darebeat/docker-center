FROM maven:3.6.3-jdk-8 AS build
WORKDIR /build
RUN git clone https://github.com/darebeat/OneBlog.git /build
RUN mvn clean package -Dmaven.test.skip=true

FROM openjdk:8-jdk-alpine
MAINTAINER darebeat<darebeat@126.com>
ARG OB_VERSION=2.2.4

WORKDIR /app/oneblog
COPY docker-entrypoint.sh /
COPY --from=build /build/blog-web/target/blog-web-$OB_VERSION.jar /app/oneblog
COPY --from=build /build/blog-admin/target/blog-admin-$OB_VERSION.jar /app/oneblog
ENV TZ=Asia/Shanghai
# EXPOSE 8085 8443

ENTRYPOINT ["/docker-entrypoint.sh"]