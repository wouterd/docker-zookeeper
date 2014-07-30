#!/bin/bash

set -ex

docker build -t wouterd/java7 java/

docker build -t wouterd/kafka kafka/

docker build -t wouterd/zookeeper zookeeper/

gradle-1-12 -p api distTar

docker build -t my-little-api api/
