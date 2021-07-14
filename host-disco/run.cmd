rem windowsversion - uses %cd% to get absolute path for CWD
docker network create docker-host-discovery_mqtt-network
docker run --network=docker-host-discovery_mqtt-network -p 1500:1500 -v %cd%:/tmp -w /tmp alpine sh /tmp/t.sh
