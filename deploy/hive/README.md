# README

## 命令

```sh
docker exec -it hive-server /opt/hive/bin/beeline -u jdbc:hive2://localhost:10000
docker exec -it hive-server hive
> CREATE TABLE pokes (foo INT, bar STRING);
> LOAD DATA LOCAL INPATH '/opt/hive/examples/files/kv1.txt' OVERWRITE INTO TABLE pokes;

docker exec -it presto presto --server localhost:8080 --catalog hive --schema default
```