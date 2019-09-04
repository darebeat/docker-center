FROM daocloud.io/darebeat/base


wget --no-check-certificate https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.198/presto-server-0.198.tar.gz \
&& mv presto-server-0.198.tar.gz /opt/presto \
&& rm -rf presto-server-0.198.tar.gz \
&& wget --no-check-certificate https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/0.198/presto-cli-0.198-executable.jar \
&& mv presto-cli-0.198-executable.jar /opt/presto/bin
