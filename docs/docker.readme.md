# README


#### Docker 安装

```sh
# 方法一
curl -fsSL https://get.docker.com/ -o get-docker.sh
bash get-docker.sh --mirror Aliyun

# 方法二
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

# 方法三 使用国内 daocloud 一键安装命令
curl -sSL https://get.daocloud.io/docker | sh
```

#### Docker-compose安装

```sh
DC_VERSION=${DC_VERSION:-1.25.0}
# https://docs.docker.com/compose/install/
curl -L "https://github.com/docker/compose/releases/download/${DC_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

#### Docker基础命令

```sh
# 删除所有容器
docker rm $(docker ps -a -q)

# 删除所有镜像
docker rmi (docker images | grep none | awk '{print3}' | sort -r)

# 一个容器连接到另一个容器
# sonar容器连接到mmysql容器，并将mmysql容器重命名为db。
# 这样，sonar容器就可以使用db的相关的环境变量了。
docker run -i -t –name sonar -d -link mmysql:db tpires/sonar-server

# 构建自己的镜像
# 如Dockerfile在当前路径：docker build -t xx/gitlab .
docker build --no-cache=ture -t <镜像名> <Dockerfile路径>

# ----- 查看容器的 -----
# 容器的状态
docker inspect -f ‘{{.State.Running}}’ $cid
# 容器的IP 
docker inspect –format=’{{.NetworkSettings.IPAddress}}’ 87d22e81a3a3 
```



#### Dockerfile指令

```dockerfile
# 选择镜像
FROM ubuntu:14.04

# 指定作者
MAINTAINER darebeat@126.com

# 增加标签(labels)来协助通过项目组织镜像，记录授权信息，帮助自动化，或者其他原因
# 一行一行设置标签
LABEL com.example.version="0.0.1-beta"
LABEL vendor="ACME Incorporated"
LABEL com.example.release-date="2015-02-12"
LABEL com.example.version.is-production=""

# 一行设置多个标签
LABEL com.example.version="0.0.1-beta" com.example.release-date="2015-02-12"

# 多行设置多个标签
LABEL vendor=ACME\ Incorporated \
      com.example.is-beta= \
      com.example.is-production="" \
      com.example.version="0.0.1-beta" \
      com.example.release-date="2015-02-12"


# 变量参数,可以build时候传入
## docker build --build-arg user=darebeat .
ARG user
ARG CONT_IMG_VER


# 修改环境变量将软件安装目录加到PATH
ENV PATH /usr/local/nginx/bin:$PATH # 将使 CMD [“nginx”] 可以工作

# 也可用于指定通用版本号，这样版本易于维护
ENV PG_MAJOR 9.3
ENV PG_VERSION 9.3.4
ENV CONT_IMG_VER ${CONT_IMG_VER:-v1.0.0}

# 运行系统构建指令
RUN curl -SL http://example.com/postgres-$PG_VERSION.tar.xz | tar -xJC /usr/src/postgress && …
RUN apt-get update && apt-get install -y \
    aufs-tools \
    automake \
    build-essential \
    curl \
    dpkg-sig \
    libcap-dev \
    libsqlite3-dev \
    mercurial \
    reprepro \
    ruby1.9.1 \
    ruby1.9.1-dev \
    s3cmd=1.1.* \
 && rm -rf /var/lib/apt/lists/*

# 文件操作
## 对于不需要ADD tar自动提取功能的其他项目（文件，目录），应始终使用COPY
COPY requirements.txt /tmp/
ADD rootfs.tar.xz /
ADD arr[[]0].tar.xz /mydir/

## 避免如下用法,而用wget或curl
ADD http://example.com/big.tar.xz /usr/src/things/
RUN tar -xJf /usr/src/things/big.tar.xz -C /usr/src/things
RUN make -C /usr/src/things all
## 应换成如下用法
RUN mkdir -p /usr/src/things \
    && curl -SL http://example.com/big.tar.xz \
    | tar -xJC /usr/src/things \
    && make -C /usr/src/things all


# 指示容器将监听链接的端口
EXPOSE 27017
EXPOSE 80


# 默认用户
## 变量可以设置默认值
USER ${user:-root}


# 工作目录
WORKDIR /root

# 设置镜像主命令，允许镜像把它作为命令运行（然后使用CMD作为默认标识）
ENTRYPOINT ["ls"]
CMD ["--help"]

# 与辅助脚本组合使用，允许其以类似于上述命令的方式运行，即使启动工具可能需要多于一个步骤
ENTRYPOINT ["/docker-entrypoint.sh"]

# 用于运行你镜像包含中的软件，连同任意参数
CMD [“executable”, “param1”, “param2”…]
```

#### 编写Dockerfile原则

>
+ 1. 减少镜像层: 
一次RUN指令形成新的一层，尽量Shell命令都写在一行
+ 2. 使用.dockerignore文件来排除文件和目录。该文件与 .gitignore 类似
+ 3. 避免安装不需要的包,优化镜像大小: 
一次RUN形成新的一层，如果没有在同一层删除，无论文件是否最后删除，都会带到下一层，所以要在每一层清理对应的残留数据，减小镜像大小。
+ 4. 每个容器只关心一个问题
解耦应用为多个容器使水平扩容和复用容器更容易
+ 5. 对多行参数排序
 无论何时，以排序多行参数来缓解以后的变化,避免重复的包并且使里列表更容易更新。这也使得PR更容易阅读和审查。
+ 6. 减少网络传输时间: 
最好在内部有一个存放软件包的地方，提高镜像构建速度。

+ 7. 多阶段进行镜像构建
如果运行一个项目，根据咱们上面的做法，是直接把代码拷贝到基础镜像里，如果是一个需要预先代码编译的项目呢？例如JAVA语言，如何代码编译、部署在一起完成呢！
上面做法需要事先在一个Dockerfile构建一个基础镜像，包括项目运行时环境及依赖库，再写一个Dockerfile将项目拷贝到运行环境中，有点略显复杂了。
像JAVA这类语言如果代码编译是在Dockerfile里操作，还需要把源代码构建进去，但实际运行时只需要构建出的包，这种把源代码放进去有一定安全风险，并且也增加了镜像体积。
为了解决上述问题，Docker 17.05开始支持多阶段构建（multi-stage builds），可以简化Dockerfile，减少镜像大小。
例如，构建JAVA项目镜像：

```sh
# git clone https://github.com/lizhenliang/tomcat-java-demo
# cd tomcat-java-demo
# vi Dockerfile
FROM maven AS build
ADD ./pom.xml pom.xml
ADD ./src src/
RUN mvn clean package

FROM lizhenliang/tomcat
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY --from=build target/*.war /usr/local/tomcat/webapps/ROOT.war

# docker build -t demo:v1 .
# docker container run -d -v demo:v1
```
>
首先，第一个FROM 后边多了个 AS 关键字，可以给这个阶段起个名字。
然后，第二部分FROM用的我们上面构建的Tomcat镜像，COPY关键字增加了—from参数，用于拷贝某个阶段的文件到当前阶段。这样一个Dockerfile就都搞定了。


`解决了什么问题:` 减少镜像大小,快速部署、快速回滚。减少服务中断时间，同时镜像仓库占用磁盘空间也少了。