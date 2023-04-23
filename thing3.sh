#!/bin/bash

# Set up a 3-tier network using localhost to route traffic through 127.0.0.1

# Step 1: Configure the localhost

# Configure the localhost's IP address to 127.0.0.1
echo "Configuring localhost's IP address to 127.0.0.1..."
ifconfig lo 127.0.0.1

# Step 2: Set up a Tor proxy layer

# Install Tor
echo "Installing Tor..."
apt-get install tor

# Configure the Tor proxy
echo "Configuring the Tor proxy..."
echo "SOCKSPort 9050" >> /etc/tor/torrc
echo "ControlPort 9051" >> /etc/tor/torrc

# Start the Tor service
echo "Starting the Tor service..."
service tor restart

# Step 3: Set up a 0.0.0.0 using loopback protocols

# Create a loopback interface
echo "Creating a loopback interface..."
ip addr add 0.0.0.0 dev lo

# Enable IP forwarding
echo "Enabling IP forwarding..."
echo 1 > /proc/sys/net/ipv4/ip_forward

# Set up iptables rules
echo "Setting up iptables rules..."
iptables -t nat -A PREROUTING -i lo -p tcp --dport 80 -j REDIRECT --to-port 9050
iptables -t nat -A POSTROUTING -o lo -j MASQUERADE

# Step 4: Test the network

# Test the network
echo "Testing the network..."
curl --socks5-hostname 127.0.0.1:9050 http://ipinfo.io/ip
