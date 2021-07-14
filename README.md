# docker-host-discovery

### ICMP network host discovery in JSON over HTTP

**Find online hosts in own subnet, serve results as JSON over HTTP**

---



### Features:

 - Crude demo-hack, written entirely in Shell-script
 - Runs without dependencies in [Alpine Linux](https://alpinelinux.org/)-container
 - Does network host discovery using ICMP Echo (ping) and filters responding hosts.
   (NOTE: ICMP echo-replies must be enabled, `net.ipv4.icmp_echo_ignore_all=0`)
  - Single shell script for ICMP flooding, "web-server" + JSON encoding ([host-disco/icmp_discov_httpd.sh](https://github.com/kokke/docker-host-discovery/blob/main/host-disco/icmp_discov_httpd.sh))
- Publishes results as a JSON-object through HTTP (port 1500 by default) - example-output: 
   ```json
   {
       "hosts": [
           "172.24.0.1",
           "172.24.0.4",
           "172.24.0.3",
           "172.24.0.5",
           "172.24.0.2"
       ]
   }
   ```


### Moving parts:

  - MQTT server aka mosquitto
  - MQTT clients aka client-1 & client-2
  - ICMP host-discovery-service aka host-disco


### Demo:

The scripts [`run-test.sh`](https://github.com/kokke/docker-host-discovery/blob/main/run-test.sh)/[`run-test.cmd`](https://github.com/kokke/docker-host-discovery/blob/main/run-test.cmd) demonstrates this, by starting all services and then gradually stopping them again.

Running the script demonstrates the host-discovery service responding to changes approximately within a second.

