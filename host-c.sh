export DEBIAN_FRONTEND=noninteractive
sudo su
sudo apt-get update
sudo apt-get install -y tcpdump curl traceroute --assume-yes
sudo su 
# Install docker and run nginx inside
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common --assume-yes --force-yes
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce --assume-yes --force-yes
sudo mkdir -p /var/www
sudo chmod +r /var/www
sudo echo "page open" > /var/www/index.html
sudo docker run --name docker-nginx \
--restart=always \
-p 80:80 -d \
-v /var/www:/usr/share/nginx/html:ro \
nginx
ip link set dev enp0s8 up
ip addr add 13.0.1.34/24 dev enp0s8
ip route del default
ip route add default via 13.0.1.33






