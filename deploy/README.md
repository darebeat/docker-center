# 创建本地公共网络

```
docker network create --driver=bridge --subnet=172.10.0.0/16 deploy
docker network ls 
docker network inspect deploy
docker netwok rm deploy
```