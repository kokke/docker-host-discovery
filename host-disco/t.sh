rm -f ips
touch ips


function serve_http() {
  echo "Serving HTTP"

  # use netcat to make webserver on port 1500, serving contents of ips
  # 'head -c -1 <file>' removes trailing newline from file
  while true; do 
    # timeout process after some time, to reload file read from disk
    # if this is not done, the file is read then nc starts blocking - so potentially a very old read
    timeout 1 sh -c "echo -e 'HTTP/1.0 200 OK\n\n{\n  \"hosts\": [\n`cat ips | head -c -2`\n  ]\n}' | nc -l -p 1500"
    [ $? -ne 0 ] && echo 'timeout' && killall -9 nc
  done &
}


function get_ip_addr() {
  echo "Getting ip address ...";

  # get ip address using 'ip' + 'awk' + 'head' (to get single line)
  ip_addr=`ip route get 1.2.3.4 \
         | awk '{ print $7 }'   \
         | head -n 1            \
         | awk '{ split($0, a,"."); printf "%d.%d.%d", a[1],a[2],a[3] }'`;
}


function ping_subnet() {
  # ping all ips in subnet
  (                                                   \
    s=$ip_addr ;                                      \
    for i in $(seq 1 254) ;                           \
      do (                                            \
       ping -n -c 1 -W 1 $s.$i 2>&1 > /dev/null       \
    && printf "    \"%s\",\n" $s.$i) &                \
    done ;                                            \
    wait ;                                            \
  ) > ips ;
}

function ping_forever() {

  while /bin/true; do
    ping_subnet
    # print hosts JSON-object
    #echo -e "{\n  \"hosts\": [\n`cat ips | head -c -2`\n  ]\n}"
  done 
}

get_ip_addr
serve_http &
ping_forever


