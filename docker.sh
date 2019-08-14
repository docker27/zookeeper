#!/bin/bash

docker rm -f zookeeper
docker rmi qianchun27/zookeeper:3.4.12
docker build -t qianchun27/zookeeper:3.4.12 -f Dockerfile .

docker run --privileged -t -d -p 2181:2181 -v /opt/docker/zookeeper:/opt/zookeeper/ --name zookeeper qianchun27/zookeeper:3.4.12 /usr/sbin/init;

docker network connect wind_net zookeeper
docker exec -it zookeeper /bin/bash
