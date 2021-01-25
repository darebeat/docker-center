#! /bin/bash

set -e

img=$(docker images | grep darebeat/docker-zookeeper | awk '{print $3}')
if [ $imi ]; then
    docker rmi -f $img
fi

docker build -f Dockerfile -t darebeat/docker-zookeeper .