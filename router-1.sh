export DEBIAN_FRONTEND=noninteractive
# Startup commands go here
apt-get update
apt-get install -y tcpdump curl traceroute --assume-yes

# Make sure the kernel forwards packets
 sysctl net.ipv4.ip_forward=1


# Set-up the interfaces
 ip link add link enp0s8 name enp0s8.10 type vlan id 10
 ip link add link enp0s8 name enp0s8.20 type vlan id 20
sudo ip link set dev enp0s8 up
sudo ip link set dev enp0s9 up
sudo ip link set dev enp0s8.10 up
sudo ip link set dev enp0s8.20 up

sudo ip addr add 11.1.0.1/23 dev enp0s8.10
sudo ip addr add 12.0.1.1/24 dev enp0s8.20
sudo ip addr add 10.0.1.37/30 dev enp0s9

#Routing rules
sudo ip route del default
sudo ip route add default via 10.0.1.38




