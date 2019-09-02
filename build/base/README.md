# ubuntu base image

## apt 源

[sources.list](./sources.list)：使用阿里源，加快下载速度。

- 配置各个节点之间的免密登陆

## 构建

```shell
docker -t build base ./
```

## 启动集群

```bash
docker network create --subnet=172.20.0.0/16 cluster
docker run -d --name master --hostname=master --net cluster --ip 172.20.0.2 ubuntu-base bash
docker run -d --name slave1 --hostname=slave1 --net cluster --ip 172.20.0.3 ubuntu-base bash
docker run -d --name slave2 --hostname=slave2 --net cluster --ip 172.20.0.4 ubuntu-base bash
```
