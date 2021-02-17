## README

A docker commom images build and deploy.


#### env install

```sh
curl -sSL https://get.daocloud.io/docker | sh
curl -L "https://github.com/docker/compose/releases/download/1.17.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

#### build

Some docker images example for build.


#### deploy

Some docker instance deploy daily.


#### change the local mirror for fast pull speed

```sh
cat << eof > /etc/docker/daemon.json
{
  "registry-mirrors": [
    "https://7zcq3x2s.mirror.aliyuncs.com",
    "https://docker.mirrors.ustc.edu.cn"
  ]
}
eof
```

#### create docker share networks

```sh
docker network create --driver=bridge --subnet=172.10.0.0/16 deploy
docker network ls 
docker network inspect deploy
```

```xml
networks:
 deploy:
  external: true
```

#### Q&A

+ **Blog  :** [https://blog.darebeat.cn/tag/letsencrypt/](https://blog.darebeat.cn/tag/letsencrypt/)
+ **Github:** [https://github.com/darebeat/docker-center.git](https://github.com/darebeat/docker-center.git)
+ **Gitee :** [https://gitee.com/darebeat/docker-center.git](https://gitee.com/darebeat/docker-center.git)

![like/star](https://sm.darebeat.cn/images/2020/11/09/wechat-search.md.png)