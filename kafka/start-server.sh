#!/bin/bash

if [ -z ${BROKER_ID} ] ; then
  echo 'No BROKER_ID specified, please specify one between 1 and 255'
  exit -1
fi

if [ -z ${ZOO} ] ; then
  echo 'No Zookeeper connection string (ZOO) specified.'
  exit -1
fi

echo "broker.id=${BROKER_ID}"$'\n' >> /server.properties
echo "zookeeper.connect=${ZOO}"$'\n' >> /server.properties

/kafka/bin/kafka-server-start.sh /server.properties
