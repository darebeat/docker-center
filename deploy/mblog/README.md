# README

## 初始化数据库和用户

```sql
create database <DB NAME>;
create user <DB USER>@'%' identified by '<DB PASS>';
grant all privileges on chevereto.* to <DB NAME>;
flush privileges;
```

## 环境变量

```sh
cat >> .env << EOF
spring_datasource_url=jdbc:mysql://mysql:3306/<DB NAME>?useSSL=false&characterEncoding=utf8&serverTimezone=GMT%2B8
spring_datasource_username=<DB USER>
spring_datasource_password=<DB PASS>
EOF

# 或者设置
cat >> .env << EOF
MYSQL_HOST=mysql
MYSQL_PORT=3306
MYSQL_DATABASE=mblog
MYSQL_USERNAME=mblog
MYSQL_PASSWORD=mblog12345
EOF
```