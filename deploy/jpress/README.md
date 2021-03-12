# README

## 初始化数据库和用户

```sql
create database jpress CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci';
create user jpress@'%' identified by 'jpress';
grant all privileges on jpress.* to jpress;
flush privileges;
```

## 环境变量

```sh
cat > .env << EOF
JPRESS_DB_HOST=jpress_db
JPRESS_DB_PORT=3306
JPRESS_DB_NAME=jpress
JPRESS_DB_USER=jpress
JPRESS_DB_PASSWORD=jpress
EOF
```

## 数据迁移

```sh
# 1. 备份数据库
docker exec -it mysql bash -c "mysqldump -u root -p --databases jpress > /jpress.sql"

# 2. 备份存储
docker cp mysql:/jpress.sql ./
tar zcvf jpress.tar.gz ./jpress.sql
tar zcvf jpress-webapp.tar.gz --exclude=**/.git ./docker_volumes/webapp
rm -rf ./jpress.sql


# 3. 迁移到新数据库或部署环境
tar zxvf jpress.tar.gz
docker cp ./jpress.sql mysql:/jpress.sql
docker exec -it mysql bash -c "mysql -uroot -p < /jpress.sql"
rm -rf jpress*


# # 启动应用程序
docker-compose up -d
```

