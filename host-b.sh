export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump curl traceroute --assume-yes
ip link set dev enp0s8 up
ip addr add 12.0.1.2/24 dev enp0s8
ip route del default
ip route add default via 12.0.1.1
