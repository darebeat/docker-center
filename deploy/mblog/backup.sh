#! /bin/sh

DB_NAME=mblog

# 1. 备份数据库
docker exec -it mysql bash -c "mysqldump -u root -p --databases ${DB_NAME:-mblog} > /${DB_NAME:-mblog}.sql"

# 2. 备份存储
docker cp mysql:/${DB_NAME:-mblog}.sql ./
tar zcvf ${DB_NAME:-mblog}.tar.gz ./${DB_NAME:-mblog}.sql
rm -rf ./${DB_NAME:-mblog}.sql


# 3. 迁移到新数据库或部署环境
scp ./${DB_NAME:-mblog}.tar.gz xry:~/
ssh xry
tar zxvf ${DB_NAME:-mblog}.tar.gz

docker cp ./${DB_NAME:-mblog}.sql mysql:/${DB_NAME:-mblog}.sql
docker exec -it mysql bash -c "mysql -uroot -p < /${DB_NAME:-mblog}.sql"
rm -rf ${DB_NAME:-mblog}*

# 启动应用程序
cd ${PROJECT_PATH:-.}/project/docker-center/deploy/${DB_NAME:-mblog}
docker-compose up -d
