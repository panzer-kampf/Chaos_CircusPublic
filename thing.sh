
#!/bin/bash


echo "Resetting all connections..."
sudo ifconfig -a down
sudo ifconfig -a up


echo "Resetting DNS records..."
sudo dscacheutil -flushcache


echo "Setting up localhost 127.0.0.1 to route all incoming and outgoing requests..."
sudo route add -host 127.0.0.1 -net 0.0.0.0

echo "Process complete!"
