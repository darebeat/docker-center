FROM daocloud.io/darebeat/jdk8
MAINTAINER darebeat<darebeat@126.com>

ARG JENKINS_VERSION=latest

ADD http://mirrors.jenkins-ci.org/war/${JENKINS_VERSION}/jenkins.war /opt/jenkins.war
RUN chmod 644 /opt/jenkins.war
ENV JENKINS_HOME /jenkins

ENTRYPOINT ["java", "-jar", "/opt/jenkins.war"]
EXPOSE 8080
CMD [""]
