#!/bin/bash

for i in {1..4} ; do
  docker rm -f kafka${i}
done

for i in {1..5} ; do
  docker rm -f zoo${i}
done

for i in {1..5} ; do
  docker rm -f api${i}
done
