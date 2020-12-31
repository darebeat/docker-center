# Clickhouse Cluster

Clickhouse cluster with 2 shards and 2 replicas built with docker-compose.

## Test it

### step into env

```sh
docker exec -it ch1 clickhouse-client -h 127.0.0.1 --port 9000 -u root --ask-password -n -m
```

### for example

```sql
# eg1: ReplicatedMergeTree
DROP DATABASE IF EXISTS test on cluster ck_cluster;
CREATE DATABASE test on CLUSTER ck_cluster;

CREATE TABLE IF NOT EXISTS test.events_shard ON CLUSTER ck_cluster (
  event_date           Date DEFAULT toDate(now()),
  company_id           UInt32,
  product_id           UInt32
) ENGINE=ReplicatedMergeTree(
  '/clickhouse/tables/{shard}/events_shard', 
  '{replica}',
  event_date,
  (company_id),
  8192
);

CREATE TABLE IF NOT EXISTS test.events_dist ON CLUSTER ck_cluster 
AS test.events_shard
ENGINE = Distributed(ck_cluster, test, events_shard, rand());

INSERT INTO test.events_shard (company_id, product_id) VALUES (1, 11), (1, 12), (1, 13);

SELECT * FROM test.events_dist;
SELECT * FROM test.events_shard;

INSERT INTO test.events_dist (company_id, product_id) VALUES (1, 14);

SELECT * FROM test.events_dist;
SELECT * FROM test.events_shard;


# eg2: MergeTree
-- 创建表结构
CREATE TABLE test.ontime_local ON CLUSTER ck_cluster (
  FlightDate Date,
  Year UInt16
) ENGINE = MergeTree(FlightDate, (Year, FlightDate), 8192)
;

-- 创建分布表
CREATE TABLE test.ontime_all ON CLUSTER ck_cluster 
AS test.ontime_local 
ENGINE = Distributed(ck_cluster, test, ontime_local, rand());

-- 随便写入一台服务数据
insert into test.ontime_local (FlightDate,Year) values ('2020-03-12',2020);

-- 查询总表
select * from test.ontime_all;
select * from test.ontime_local;

insert into test.ontime_all (FlightDate,Year) values ('2001-10-12',2001),('2002-10-12',2002),('2003-10-12',2003);
```

## common script

```sql
# 各数据库占用空间统计
SELECT database, 
  formatReadableSize(sum(bytes_on_disk)) AS on_disk 
FROM system.parts 
GROUP BY database
;

# 存储空间统计
SELECT name,
  path,
  formatReadableSize(free_space) AS free,
  formatReadableSize(total_space) AS total,
  formatReadableSize(keep_free_space) AS reserved 
FROM system.disks
;

# 当前连接数
SELECT * 
FROM system.metrics 
WHERE metric LIKE '%Connection'
;

# 当前正在执行的查询
SELECT query_id, 
  user, 
  address, 
  query 
FROM system.processes 
ORDER BY query_id
;

# 终止查询
KILL QUERY WHERE query_id='ff695827-dbf5-45ad-9858-a853946ea140';

# 慢查询
SELECT user, 
  client_hostname AS host, 
  client_name AS client, 
  formatDateTime(query_start_time,'%T') AS started, 
  query_duration_ms/1000 AS sec,
  round(memory_usage/1048576) AS MEM_MB, 
  result_rows AS RES_CNT, 
  result_bytes/1048576 AS RES_MB, 
  read_rows AS R_CNT, 
  round(read_bytes/1048576) AS R_MB, 
  written_rows AS W_CNT, 
  round(written_bytes/1048576) AS W_MB, 
  query 
FROM system.query_log 
WHERE type = 2 
ORDER BY query_duration_ms DESC 
LIMIT 10
;
```
