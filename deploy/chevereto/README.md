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
cat >> .env_mysql << EOF
CHEVERETO_DB_HOST=<DB HOST>
CHEVERETO_DB_USERNAME=<DB USER>
CHEVERETO_DB_PASSWORD=<DB PASS>
CHEVERETO_DB_NAME=<DB NAME>
CHEVERETO_DB_PREFIX=chv_
EOF
```


## 修改密码

```sql
update chv_logins 
set login_secret='$2y$10$kEJK8EdbnulBLiAGvxVF9.xgPnD3kTJEc.LsLWvX95.gaZmqo.1EW' 
where login_user_id=1 and login_type='password'
;
```