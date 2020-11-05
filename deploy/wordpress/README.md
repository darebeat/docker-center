# README

## 初始化数据库和用户

```sql
create database <wordpress database>;
create user <wordpress user>@'%' identified by '<wordpress pass>';
grant all privileges on <wordpress user>.* to <wordpress database>;
flush privileges;
```

## 环境变量

```sh
cat >> .env_mysql << EOF
MYSQL_ROOT_PASSWORD=<your root pass>
MYSQL_USER=<wordpress user>
MYSQL_PASSWORD=<wordpress pass>
MYSQL_DATABASE=<wordpress database>
EOF

cat >> .env_wp_all << EOF
WORDPRESS_DB_HOST=db:3306
WORDPRESS_DB_USER=<wordpress user>
WORDPRESS_DB_PASSWORD=<wordpress pass>
WORDPRESS_DB_NAME=<wordpress database>
EOF
```