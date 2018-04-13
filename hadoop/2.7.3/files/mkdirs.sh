#!/bin/bash
# Basic range in for loop
for i in {1..17}

do
	
	

	sudo rm -rf /mnt/ssd$i/hdfs
	sudo rm -rf /mnt/ssd$i/hadooptmp
	sudo mkdir -p /mnt/ssd$i/hdfs/namenode
	sudo mkdir -p /mnt/ssd$i/hdfs/datanode
        sudo mkdir -p /mnt/ssd$i/hadooptmp
	sudo chown -R vlad:vlad /mnt/ssd$i/hdfs
	sudo chown -R vlad:vlad /mnt/ssd$i/hadooptmp
done

echo All done
