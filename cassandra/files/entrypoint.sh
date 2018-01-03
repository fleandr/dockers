#!/bin/bash

read -r -d '' USAGE << EOS
Usage: $0 master [MASTER_IP]
       $0 slave [MASTER_HOSTNAME] [SLAVE_IP]

MASTER_HOSTNAME is "master" by default.

IPs are needed only when using host network option with Docker in order to
correctly setup /etc/hosts for Hadoop.
EOS

case $1 in
  master)


    # start sshd
    service ssh start
    # update Hadoop config with master hostname
    HOSTNAME=`hostname`
    # update /etc/hosts with IP (only needed when using host networking)
    if [ -n $2 ]; then
      cp /etc/hosts /tmp/hosts
      sed -i "s/127.0.1.1/$2/g" /tmp/hosts
      cp /tmp/hosts /etc/hosts
    fi
    # start Hadoop daemons
    # keep container running
    tail -f /var/log/dmesg

    ;;
  slave)
    service ssh start
        # update Hadoop config with master hostname
	    HOSTNAME=`hostname`
	  # start sshd
    if [ -n $3 ]; then
      cp /etc/hosts /tmp/hosts
      sed -i "s/127.0.1.1/$3/g" /tmp/hosts
      cp /tmp/hosts /etc/hosts
    fi
    # start Hadoop daemons
    # keep container running
    tail -f /var/log/dmesg
    ;;
  *)
    echo "$USAGE"
    ;;
esac
