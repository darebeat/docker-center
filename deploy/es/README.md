# 问题处理

+ 目录无限问题

```sh
chown 1000:1000 master/data
chown 1000:1000 node1/data
chown 1000:1000 node2/data
```

+ 虚拟内存不够问题

```sh
# 1.命令行参数设置
sysctl -w vm.max_map_count=262144 # 设置虚拟内存


# 2.修改文件配置参数设置
cat << EOF >> /etc/sysctl.conf
vm.max_map_count=262144
EOF
sysctl -p

# 3.查看结果
sysctl -a|grep vm.max_map_count 
```

+ 各个节点说明

```
es-master：master节点，确定分片位置，索引的新增、删除请求分配
es-node1：分片的 CRUD，以及搜索和整合操作
es-node2：分片的 CRUD，以及搜索和整合操作
es-head：es的一个插件，可以浏览和查看数据，可以类比于navcate相对于mysql的作用。
```