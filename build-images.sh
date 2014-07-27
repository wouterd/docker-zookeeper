#!/bin/bash

docker build -t wouterd/java7 java/

docker build -t wouterd/kafka kafka/

docker build -t wouterd/zookeeper zookeeper/
