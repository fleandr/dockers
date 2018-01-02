#!/bin/bash
# Basic range in for loop
for i in {1..10}

do
	
	for j in {1..10}
	do
	sudo rm -rf /mnt/ssd$i/node$j
	sudo mkdir -p /mnt/ssd$i/node$j
	sudo chown -R vlad:vlad /mnt/ssd$i/node$j
done

done
echo All done
