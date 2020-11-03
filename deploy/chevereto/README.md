# README

初始化数据库和用户

```sql
create database chevereto;
create user chevereto@'%' identified by 'chevereto0755';
grant all privileges on chevereto.* to chevereto;
flush privileges;
```