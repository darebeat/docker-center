FROM maven:3.6.3-jdk-8 AS build
WORKDIR /build
RUN git clone https://github.com/KOHGYLW/kiftd.git /build
RUN rm -rf /build/.git /build/*.pdf

FROM openjdk:8-jdk-alpine
MAINTAINER darebeat<darebeat@126.com>

WORKDIR /app/kiftd
COPY --from=build /build/ /app/kiftd

EXPOSE 8080
CMD ["java","-jar", "kiftd-1.0.35-RELEASE.jar", "-start"]