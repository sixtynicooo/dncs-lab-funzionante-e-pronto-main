export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump
apt-get install -y openvswitch-common openvswitch-switch apt-transport-https ca-certificates curl software-properties-common

# Startup commands for switch go here

ovs-vsctl add-br switch
sudo ip link set dev enp0s8 up
sudo ip link set dev enp0s9 up
sudo ip link set dev enp0s10 up
# The access ports
ovs-vsctl --may-exist add-port switch enp0s9 tag=10
ovs-vsctl --may-exist add-port switch enp0s10 tag=20

# And the trunk link 
ovs-vsctl --may-exist add-port switch enp0s8