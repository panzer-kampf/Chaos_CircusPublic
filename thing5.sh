#!/bin/bash

#This script will trace the origin of all incoming requests and redirect all requests back to sender
#showing the traceroute and IP address of each reverse hop

#Define variables
IP_ADDRESS=$1

#Check if user provided an IP address
if [ -z "$IP_ADDRESS" ]; then
  echo "Please provide an IP address"
  exit
fi

#Trace the origin of the incoming request
echo "Tracing origin of incoming request from $IP_ADDRESS"
traceroute -n $IP_ADDRESS

#Redirect request back to sender
echo "Redirecting request back to sender"
iptables -t nat -A OUTPUT -p tcp -d $IP_ADDRESS -j REDIRECT --to-ports $IP_ADDRESS

#Print the traceroute and IP address of each reverse hop
echo "Printing traceroute and IP address of each reverse hop"
traceroute -n -I $IP_ADDRESS | awk '{print $2}' | while read IP_ADDRESS; do
  echo "IP Address: $IP_ADDRESS"
  traceroute -n $IP_ADDRESS
done
