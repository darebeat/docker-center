## README

+ 进入容器

```sh
docker exec -it mongodb /bin/bash
mongo
```

+ 创建账号权限

```js
use admin
db.createUser({ user: 'root', pwd: 'root', roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] })
db.auth("root","root")
show users


use survey
db.createUser(
  {
    user: "cet_read",
    pwd: "cE)t4Ne28(p",
    roles: [ { role: "readWrite", db: "survey" }
             ]
  }
)
db.auth("cet_read","cE)t4Ne28(p")
```

+ 内建角色

  - Read：允许用户读取指定数据库
  - readWrite：允许用户读写指定数据库
  - dbAdmin：允许用户在指定数据库中执行管理函数，如索引创建、删除，查看统计或访问system.profile
  - userAdmin：允许用户向system.users集合写入，可以找指定数据库里创建、删除和管理用户
  - clusterAdmin：只在admin数据库中可用，赋予用户所有分片和复制集相关函数的管理权限。
  - readAnyDatabase：只在admin数据库中可用，赋予用户所有数据库的读权限
  - readWriteAnyDatabase：只在admin数据库中可用，赋予用户所有数据库的读写权限
  - userAdminAnyDatabase：只在admin数据库中可用，赋予用户所有数据库的userAdmin权限
  - dbAdminAnyDatabase：只在admin数据库中可用，赋予用户所有数据库的dbAdmin权限。
  - root：只在admin数据库中可用。超级账号，超级权限

+ 登陆

```sh
# way 1
mongo --host localhost --port 27017 \
-u "cet_read" \
-p "cE)t4Ne28(p" \
--authenticationDatabase "survey"

# way 2
mongo --host localhost --port 27017
use survey
db.auth("cet_read", "cE)t4Ne28(p")
```
