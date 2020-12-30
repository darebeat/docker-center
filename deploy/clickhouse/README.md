# Clickhouse Cluster

Clickhouse cluster with 2 shards and 2 replicas built with docker-compose.

## Test it

### step into env

```sh
docker exec -it ch1 clickhouse-client -h 127.0.0.1 --port 9000 -u default --ask-password -n
```

### for example

```sql
CREATE DATABASE test on CLUSTER db_cluster;

CREATE TABLE IF NOT EXISTS test.events_shard ON CLUSTER db_cluster (
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

CREATE TABLE IF NOT EXISTS test.events_dist ON CLUSTER db_cluster 
AS test.events_shard
ENGINE = Distributed(db_cluster, test, events_shard, rand());

INSERT INTO test.events_dist (company_id, product_id) VALUES (1, 11), (1, 12), (1, 13);

SELECT * FROM test.events_dist;
SELECT * FROM test.events_shard;

INSERT INTO test.events_dist (company_id, product_id) VALUES (1, 14);
```