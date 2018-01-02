#!/bin/bash
docker run -v /mnt/ssd4/node1:/mnt/ssd4 -v /mnt/ssd3/node1:/mnt/ssd3 -v /mnt/ssd2/node1:/mnt/ssd2 -d --net hadoop-net --name master --hostname master ubuntu:hadoopspark  master
docker run -v /mnt/ssd4/node2:/mnt/ssd4 -v /mnt/ssd3/node2:/mnt/ssd3 -v /mnt/ssd2/node2:/mnt/ssd2 -d --net hadoop-net --name slave01 --hostname slave01 ubuntu:hadoopspark  slave
docker run -v /mnt/ssd4/node3:/mnt/ssd4 -v /mnt/ssd3/node3:/mnt/ssd3 -v /mnt/ssd2/node3:/mnt/ssd2 -d --net hadoop-net --name slave02 --hostname slave02 ubuntu:hadoopspark  slave
