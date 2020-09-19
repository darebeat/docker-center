## Flink in Docker
---
This is a Docker image appropriate for running Flink in Kuberenetes. You can also run it locally with docker-compose in which case you get two containers by default:

+ flink-jobmanager - runs a Flink Job Manager in cluster mode and exposes a port for Flink and a port for the WebUI.
+ flink-taskmanager - runs a Flink Task Manager and connects to the Flink Job Manager via static DNS name flink-jobmanager.
The Docker setup is heavily influenced by docker-flink

## Usage

### Run locally
--- 
Get the `docker-compose.yml` from Github and then use the following snippets

#### Start JobManager and TaskManager

```sh
docker-compose up -d will start a Job Manager with a single Task Manager in background.
```

#### Scale TaskManagers

```sh
docker-compose scale flink-taskmanager=5 will scale to 5 Task Managers.
```

#### Deploy and Run a Job

+ Copy the Flink job JAR to the Job Manager

```sh
docker cp /path/to/job.jar $(docker ps --filter name=flink-jobmanager --format={{.ID}}):/job.jar to
```
+ Copy the data to each Flink node if necessary

```sh
for i in $(docker ps --filter name=flink --format={{.ID}}); do
  docker cp /path/to/data.csv $i:/data.csv
done
```

### Run the job
---

```sh
docker exec -it $(docker ps --filter name=flink-jobmanager --format={{.ID}}) flink run -c <your_job_class> /job.jar [optional params]
```

where optional params could for example point to the dataset copied at the previous step.

Accessing Flink Web Dashboard
Navigate to [http://localhost:8081](http://localhost:8081)

### Stop Flink Cluster

```sh
docker-compose down # shuts down the cluster.
```