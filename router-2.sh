export DEBIAN_FRONTEND=noninteractive
# Startup commands go here
apt-get update
apt-get install -y tcpdump curl traceroute --assume-yes

# Make sure the kernel forwards packets
sysctl net.ipv4.ip_forward=1


# Set-up the interfaces
sudo ip link set dev enp0s8 up
sudo ip link set dev enp0s9 up
sudo ip addr add 13.0.1.33/24 dev enp0s8
sudo ip addr add 10.0.1.38/30 dev enp0s9


#Easy way: forward everything to the other router

sudo ip route del default
sudo ip route add default via 10.0.1.37
