# README

## mysql 授权

```sql
-- 创建数据库
create database test CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci';
-- 创建用户
create user test@'%' identified by 'test0755';

-- 修改用户密码
alter user 'test'@'%' identified by '123';  

-- 授予用户test管理test的全部权限
-- grant select,insert,update,delete
grant all privileges on test.* to test;

-- 刷新
flush privileges;

-- 备份数据库
mysqldump -u test -p test > test.sql

-- 还原数据库
use test;
source $(pwd)/test.sql
```

## 环境变量

```sh
cat >> .env_mysql << EOF
MYSQL_ROOT_PASSWORD=<your root pass>
MYSQL_USER=<custom your user>
MYSQL_PASSWORD=<custom your pass>
MYSQL_DATABASE=<custom your database>
EOF
```