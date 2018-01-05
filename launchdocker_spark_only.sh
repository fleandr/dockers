#!/bin/bash
docker run -v /mnt/ssd4/node1:/mnt/ssd4 -v /mnt/ssd3/node1:/mnt/ssd3 -v /mnt/ssd2/node1:/mnt/ssd2 -d --net hadoop-net --name master2 --hostname master2 ubuntu:spark  master
docker run -v /mnt/ssd4/node2:/mnt/ssd4 -v /mnt/ssd3/node2:/mnt/ssd3 -v /mnt/ssd2/node2:/mnt/ssd2 -d --net hadoop-net --name sslave01 --hostname sslave01 ubuntu:spark worker spark://master2:7077
docker run -v /mnt/ssd4/node3:/mnt/ssd4 -v /mnt/ssd3/node3:/mnt/ssd3 -v /mnt/ssd2/node3:/mnt/ssd2 -d --net hadoop-net --name sslave02 --hostname sslave02 ubuntu:spark worker spark://master2:7077
