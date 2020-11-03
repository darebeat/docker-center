# README

初始化数据库和用户

```sql
create database wordpress;
create user wordpress@'%' identified by 'wordpress0755';
grant all privileges on wordpress.* to wordpress;
flush privileges;
```