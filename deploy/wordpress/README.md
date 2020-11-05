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

## 博客搬家

+ 替换域名

```sh
OLD_DOMAIN=127.0.0.1:8080
NEW_DOMAIN=blog.darebeat.cn:8080

mysql -uroot -p -e "
UPDATE wp_options SET option_value = REPLACE(option_value,'${OLD_DOMAIN}','${NEW_DOMAIN}');
UPDATE wp_posts SET post_content = replace(post_content,'${OLD_DOMAIN}','${NEW_DOMAIN}')
, post_excerpt= replace(post_excerpt,'${OLD_DOMAIN}','${NEW_DOMAIN}');
, guid= replace(guid, '${OLD_DOMAIN}','${NEW_DOMAIN}');
"
```