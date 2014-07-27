#!/bin/bash

if [ -z ${ZOO_ID} ] ; then
  echo 'No ID specified, please specify one between 1 and 255'
  exit -1
fi

if [ ! -f /conf/zoo.cfg ] ; then
  echo 'Waiting for config file to appear...'
  while [ ! -f /conf/zoo.cfg ] ; do
    sleep 1
  done
  echo 'Config file found, linking it.'
  ln -s /conf/zoo.cfg /zoo/conf/zoo.cfg
fi

mkdir -p /var/lib/zookeeper

echo "${ZOO_ID}" > /var/lib/zookeeper/myid

/zoo/bin/zkServer.sh start-foreground
