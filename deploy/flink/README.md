# Flink in Docker


## 创建网络

```sh
docker network create --driver=bridge --subnet=172.18.0.0/16 flink
docker network ls 
docker network inspect flink
```

## 使用网络

```xml
jobmanager:
  image: flink:${FLINK_VERSION:-1.11.0-scala_2.11}
  ports:
    - "8081:8081"
  command: jobmanager
  container_name: flink-jobmanager
  hostname: jobmanager
  networks:
    flink:
      ipv4_address: 172.18.0.2
      aliases:
        - jobmanager

networks:
  flink:
    external: true
```


## 使用

```sh
git clone https://github.com/darebeat/docker-center.git
cd docker-center/deploy/flink/1.12.2

# Start JobManager and TaskManager
docker-compose up -d

# scale to 5 Task Managers.
docker-compose scale flink-taskmanager=5 

# Copy the Flink job JAR to the Job Manager
docker cp /path/to/job.jar flink-jobmanager:/job.jar 

for i in $(docker ps --filter name=flink --format={{.ID}}); do
  docker cp /path/to/data.csv $i:/data.csv
done

# Run the job
docker exec -it flink-jobmanager flink run -c <your_job_class> /job.jar [optional params]

# Stop Flink Cluster
docker-compose down # shuts down the cluster.
```

## Accessing Flink Web Dashboard

Navigate to [http://localhost:8081](http://localhost:8081)
