#!/bin/bash

#This script will route all incoming traffic through a loopback feature and log the networks that are sending requests and geolocate each IP
#Set up loopback
echo "Setting up loopback..."
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to-destination 127.0.0.1

#Log incoming requests and geolocate each IP
echo "Logging incoming requests and geolocating each IP..."
while true; do
  sudo tcpdump -i eth0 -n -l -c 50 -s 0 -A "port 80" | while read line; do
    echo "$line"
    IP=$(echo $line | grep -oE "\b([0-9]{1,3}.){3}[0-9]{1,3}\b" | head -1)
    if [ -n "$IP" ]; then
      echo "$IP"
      curl http://ip-api.com/json/$IP
    fi
  done
done
