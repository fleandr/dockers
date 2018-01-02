#create doker ubuntu:hadoopspark

docker build . -t ubuntu:hadoopspark
./mkdirs.sh
./launchdocker.sh
docker exec -i -t master /bin/bash

# spark start manually by ./root/start-master-fg.sh&
# go to slaves docker exec -i -t slave01 /bin/bash docker exec -i -t slave02 /bin/bash then  start-worker-fg.sh spark://master:7077&
# go to HiBench change ./conf hadoop.conf.template to hadoop.conf and spark.conf.template to spark.conf  and put directories there (all in /opt/hadoop-2.7.3 
#and /opt/spark-2.1.0)

#compile HiBench ../bin/build-all.sh and then run ../bin/run.sh
