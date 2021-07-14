# unix version - uses `pwd` to get absolute path for CWD
docker network create docker-host-discovery_mqtt-network
docker run --network=docker-host-discovery_mqtt-network -p 1500:1500 -v `pwd`:/tmp -w /tmp alpine sh /tmp/t.sh
