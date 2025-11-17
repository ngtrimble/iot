#!/usr/bin/env bash
set -xe -o pipefail

#docker stop mosquitto-sub
docker run --name mosquitto-sub -d --rm eclipse-mosquitto mosquitto_sub -h mosquitto -u iotdev -P abcd1234 -t "test/topic" --pretty

for i in {0..99}
do
    docker run --name mosquitto-pub -it --rm eclipse-mosquitto mosquitto_pub -h mosquitto -u iotdev -P abcd1234 -t "test/topic" -m "{\"i\": $i}"
done

docker logs mosquitto-sub 
docker stop mosquitto-sub
