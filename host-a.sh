export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump curl traceroute --assume-yes
ip link set dev enp0s8 up
ip addr add 11.1.0.2/23 dev enp0s8
ip route del default
ip route add default via 11.1.0.1

