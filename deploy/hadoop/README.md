# README

## 运行实例

```sh
docker pull sequenceiq/hadoop-docker:2.7.1
# 部署实例
docker-compose up -d
# 销毁实例
docker-compose down -v
```

## APP信息和日志记录查看

```sh
# 宿主机上在`/etc/hosts`新增一条配置,如下
127.0.0.1 hdfs

# Yarn
http:/hdfs:8088
# Hadoop 资源信息
http:/hdfs:50070
```

## 运行实例测试

```sh
docker exec -it hdfs bash
# run the mapreduce
hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar grep input output 'dfs[a-z.]+'

# check the output
hdfs dfs -cat output/*
```

## HDFS常用命令行操作

```sh
# 列出HDFS文件
hadoop fs -ls
hadoop fs -ls /user/root
hadoop fs -ls input

# 创建hdfs目录
hadoop fs -mkdir /user/root/test
hadoop fs -ls /user/root

# 上传文件到HDFS
echo '1111' > ./file
hadoop fs -put ./file test
hadoop fs -ls /user/root/test

# 查看HDFS下某个文件
hadoop fs -cat /user/root/test/file

# 将HDFS中文件复制到本地系统中
hadoop fs -get test getout
ll getout

# 删除HDFS下的文档
hadoop fs –rmr test
hadoop fs -ls 

# 报告HDFS的基本统计情况
hadoop dfsadmin -report
```