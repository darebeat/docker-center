#! /bin/sh

# 1. 备份数据库
docker exec -it mysql57 bash
mysqldump -u root -p --databases mblog > /bak.sql
exit

# 2. 备份存储
docker cp mysql57:/bak.sql ./storage
tar zcvf mblog.tar.gz ./storage


# 3. 迁移到新数据库或部署环境
tar zxvf mblog.tar.gz

docker cp ./storage/bak.sql mysql57:/bak.sql
docker exec -it mysql57 bash
mysql -uroot -p < /bak.sql
exit

# 启动应用程序
docker-compose up -d
