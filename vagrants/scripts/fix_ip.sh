# vmware bug to set the ip
# see : https://github.com/hashicorp/vagrant/issues/5000#issuecomment-258209286

# eth0 = NAT
# eth1 = bridge
# eth 2 = internal

sed -i '/Name=en.*/d' /etc/systemd/network/80-dhcp.network
sed -i 's/Name=eth.*/Name=eth0/g' /etc/systemd/network/80-dhcp.network
systemctl restart systemd-networkd
echo "Gateway=$1" >>  /etc/systemd/network/eth1.network

